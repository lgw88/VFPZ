param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$PromptFile,
    [string]$StateDirectory,
    [string]$Repository,
    [int]$IssueNumber = 0,
    [int]$MaxIterations = 0,
    [int]$IdleLimit = 2,
    [int]$CodexRetryCount = 3,
    [switch]$BypassSandbox,
    [switch]$UseBroadPrompt,
    [switch]$SkipValidation,
    [switch]$SkipIssueClosing,
    [switch]$CloseCatchUpIssuesOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($PromptFile)) {
    $PromptFile = Join-Path $RepoRoot "codex-resume-prompt.txt"
}

if ([string]::IsNullOrWhiteSpace($StateDirectory)) {
    $StateDirectory = Join-Path $RepoRoot ".codex-driver"
}

if (-not $PSBoundParameters.ContainsKey("BypassSandbox")) {
    $BypassSandbox = $true
}

if (-not (Test-Path -LiteralPath $PromptFile)) {
    throw "Prompt file not found: $PromptFile"
}

New-Item -ItemType Directory -Path $StateDirectory -Force | Out-Null

$stopFile = Join-Path $StateDirectory "STOP"
$historyFile = Join-Path $StateDirectory "history.log"
$lastMessageFile = Join-Path $StateDirectory "last-message.txt"

$relatedTitlePatterns = @(
    "DBF/FPT fidelity",
    "Data-session parity",
    "Alias/work-area parity",
    "Aggregate follow-through",
    "A1:",
    "A2:",
    "A3:"
)

$issueCompletionSentinels = @{
    44 = @("aggregate command follow-through now covers first-pass scope-clause and `WHILE` semantics")
    45 = @("first-pass `TOTAL` now works for local DBF-backed cursors")
    49 = @("first-pass `TOTAL` now works for local DBF-backed cursors")
    50 = @("aggregate command follow-through now includes first-pass `IN <alias|work area>` targeting")
    51 = @("`USE ... IN <alias|work area>` now preserves the current selected work area")
    52 = @("plain `USE <table>` now reuses the current selected work area")
    53 = @("synthetic SQL result cursors now have stronger data-session isolation")
    55 = @("`SQLCONNECT()` handle numbering now restarts per data session")
    56 = @("`SET NEAR` now has focused data-session restoration coverage")
    58 = @("the shared DBF layer now has first-pass memo write fidelity for `M` fields")
}

$priorityIssueNumbers = @(
    54,
    55, 56, 58, 52, 51, 50, 49,
    44, 45,
    9, 10, 11, 12,
    13, 14,
    15, 16, 17, 18,
    19, 20, 21,
    22, 23, 24,
    25, 26,
    27, 28, 29,
    30, 31, 32,
    33, 34,
    35, 36, 37,
    38, 39, 40, 41,
    42, 43, 46, 47, 48, 57,
    6, 5, 7, 8,
    1, 2, 3, 4
)

function Write-History {
    param([string]$Message)

    $line = "[{0}] {1}" -f (Get-Date -Format "s"), $Message
    $line | Tee-Object -FilePath $historyFile -Append
}

function Get-RepositoryName {
    param([string]$RemoteUrl)

    if ($RemoteUrl -match "github\.com[:/](?<name>[^/]+/[^/.]+?)(?:\.git)?$") {
        return $Matches.name
    }

    throw "Could not determine owner/repo from remote URL: $RemoteUrl"
}

function Get-TrackedText {
    $remainingWork = Get-Content -LiteralPath (Join-Path $RepoRoot "remaining-work.md") -Raw
    $coverage = Get-Content -LiteralPath (Join-Path $RepoRoot "docs\22-vfp-language-reference-coverage.md") -Raw
    return "$remainingWork`n$coverage"
}

function Get-OpenRelatedIssues {
    $json = gh issue list --repo $Repository --state open --limit 200 --json number,title,url
    $issues = $json | ConvertFrom-Json
    return @(
        $issues | Where-Object {
            $title = $_.title
            foreach ($pattern in $relatedTitlePatterns) {
                if ($title.IndexOf($pattern, [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
                    return $true
                }
            }

            return $false
        }
    )
}

function Get-IssuePriorityRank {
    param([int]$Number)

    $index = [Array]::IndexOf($priorityIssueNumbers, $Number)
    if ($index -ge 0) {
        return $index
    }

    return 100000 + $Number
}

function Get-TargetIssue {
    param(
        [object[]]$OpenIssues,
        [int]$RequestedIssueNumber = 0
    )

    if ($RequestedIssueNumber -gt 0) {
        $requested = @($OpenIssues | Where-Object { [int]$_.number -eq $RequestedIssueNumber })
        if ($requested.Count -eq 0) {
            throw "Requested issue #$RequestedIssueNumber is not open or is not part of the tracked backlog."
        }

        return $requested[0]
    }

    $ordered = @(
        $OpenIssues |
            Sort-Object -Property @{ Expression = { Get-IssuePriorityRank -Number ([int]$_.number) } }, @{ Expression = { [int]$_.number } }
    )

    if ($ordered.Count -eq 0) {
        return $null
    }

    return $ordered[0]
}

function Get-Array {
    param([object]$Value)

    if ($null -eq $Value) {
        return @()
    }

    return @($Value)
}

function Get-CompletedIssueNumbersFromMessage {
    param([string]$Message)

    $match = [regex]::Match($Message, "COMPLETED_ISSUES:\s*(?<value>.+)")
    if (-not $match.Success) {
        return @()
    }

    $value = $match.Groups["value"].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($value) -or $value.Equals("none", [System.StringComparison]::OrdinalIgnoreCase)) {
        return @()
    }

    $numbers = New-Object System.Collections.Generic.List[int]
    foreach ($part in ($value -split ",")) {
        $trimmed = $part.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed)) {
            continue
        }

        $trimmed = $trimmed.TrimStart('#')
        $parsed = 0
        if ([int]::TryParse($trimmed, [ref]$parsed)) {
            $numbers.Add($parsed) | Out-Null
        }
    }

    return @($numbers | Select-Object -Unique)
}

function Test-IssueCompleted {
    param(
        [int]$IssueNumber,
        [string]$TrackedText
    )

    if (-not $issueCompletionSentinels.ContainsKey($IssueNumber)) {
        return $false
    }

    foreach ($sentinel in $issueCompletionSentinels[$IssueNumber]) {
        if (-not $TrackedText.Contains($sentinel, [System.StringComparison]::Ordinal)) {
            return $false
        }
    }

    return $true
}

function Get-ValidationBlock {
    return @"
- Push-Location \"$RepoRoot\"; cmake --build build --config Release --target test_dbf_table test_prg_engine; Pop-Location
- & \"$RepoRoot\build\Release\test_dbf_table.exe\"
- & \"$RepoRoot\build\Release\test_prg_engine.exe\"
"@
}

function Get-TargetedPrompt {
    param(
        [object]$TargetIssue,
        [object[]]$OpenIssues
    )

    $repoDocsPath = Join-Path $RepoRoot "remaining-work.md"
    $coverageDocPath = Join-Path $RepoRoot "docs\22-vfp-language-reference-coverage.md"
    $runtimeFiles = @(
        (Join-Path $RepoRoot "src\runtime\prg_engine.cpp"),
        (Join-Path $RepoRoot "tests\test_prg_engine.cpp"),
        (Join-Path $RepoRoot "include\copperfin\vfp\dbf_table.h"),
        (Join-Path $RepoRoot "src\vfp\dbf_table.cpp"),
        (Join-Path $RepoRoot "tests\test_dbf_table.cpp"),
        $repoDocsPath,
        $coverageDocPath
    ) -join "`n- "

    $otherOpenIssues = @(
        $OpenIssues |
            Where-Object { [int]$_.number -ne [int]$TargetIssue.number } |
            Sort-Object -Property @{ Expression = { Get-IssuePriorityRank -Number ([int]$_.number) } }, @{ Expression = { [int]$_.number } } |
            Select-Object -First 8 |
            ForEach-Object { "#{0}: {1}" -f $_.number, $_.title }
    )
    $otherOpenIssuesText = if ($otherOpenIssues.Count -gt 0) { $otherOpenIssues -join "`n- " } else { "none" }

    return @"
You are continuing Project-Copperfin in the repository rooted at: $RepoRoot

Work exactly one issue in this turn:
- #$($TargetIssue.number): $($TargetIssue.title)

Requirements:
- Use ONLY absolute Windows paths rooted under $RepoRoot for all file reads, edits, and shell commands. Relative paths are unreliable in this environment.
- Run Codex commands from the repository root.
- Inspect only the files directly relevant to issue #$($TargetIssue.number) before editing.
- Make the minimal code changes needed for this issue only.
- Add or update focused regression coverage.
- Run validation after edits using these commands:
$(Get-ValidationBlock)
- Update docs only if shipped behavior changes:
  - $repoDocsPath
  - $coverageDocPath
- Do not work on any other issue in this turn.
- Do not close issues yourself.

Helpful likely-relevant files for runtime/data slices:
- $runtimeFiles

Other currently open backlog items to ignore for this turn:
- $otherOpenIssuesText

Final response requirements:
- End with exactly one line in this format: COMPLETED_ISSUES: $($TargetIssue.number) or COMPLETED_ISSUES: none
"@
}

function Invoke-NarrowValidation {
    Write-History "Running narrow validation."
    Push-Location $RepoRoot
    try {
        & cmake --build build --config Release --target test_dbf_table test_prg_engine
        & (Join-Path $RepoRoot "build\Release\test_dbf_table.exe")
        & (Join-Path $RepoRoot "build\Release\test_prg_engine.exe")
    }
    finally {
        Pop-Location
    }
}

function Close-VerifiedCompletedIssues {
    param(
        [int[]]$AllowedIssueNumbers = @()
    )

    if ($SkipIssueClosing) {
        return @()
    }

    $trackedText = Get-TrackedText
    $openIssues = Get-OpenRelatedIssues
    $closedNumbers = New-Object System.Collections.Generic.List[int]
    $allowedLookup = @{}

    foreach ($number in (Get-Array $AllowedIssueNumbers)) {
        $allowedLookup[[int]$number] = $true
    }

    foreach ($issue in $openIssues) {
        if ($allowedLookup.Count -gt 0 -and -not $allowedLookup.ContainsKey([int]$issue.number)) {
            continue
        }

        $canClose = Test-IssueCompleted -IssueNumber $issue.number -TrackedText $trackedText
        if (-not $canClose) {
            continue
        }

        Write-History ("Closing verified completed issue #{0}: {1}" -f $issue.number, $issue.title)
        gh issue close $issue.number --repo $Repository --reason completed --comment "Verified from the current repo state and backlog docs." | Out-Null
        $closedNumbers.Add([int]$issue.number) | Out-Null
    }

    return $closedNumbers
}

function Get-StatusSnapshot {
    Push-Location $RepoRoot
    try {
        return (git status --short) -join "`n"
    }
    finally {
        Pop-Location
    }
}

function Invoke-CodexPass {
    param(
        [int]$Iteration,
        [object]$TargetIssue,
        [object[]]$OpenIssues
    )

    $prompt = if ($UseBroadPrompt) {
        $basePrompt = Get-Content -LiteralPath $PromptFile -Raw
        $issueLines = if ($OpenIssues.Count -gt 0) {
            ($OpenIssues | ForEach-Object { "- #{0}: {1}" -f $_.number, $_.title }) -join "`n"
        }
        else {
            "- none"
        }

        $automationPrompt = @"

Automation instructions:
- Continue the highest-priority unfinished runtime/data-engine slice from the current repo state.
- Keep the repo buildable and run the narrow validation before you stop.
- Update remaining-work.md and docs/22-vfp-language-reference-coverage.md when shipped behavior changes.
- End your final message with exactly one line in this format: COMPLETED_ISSUES: <comma-separated issue numbers or none>

Currently open related issues:
$issueLines
"@

        $basePrompt + $automationPrompt
    }
    else {
        Get-TargetedPrompt -TargetIssue $TargetIssue -OpenIssues $OpenIssues
    }
    $arguments = @(
        "exec",
        "--json",
        "--color", "never",
        "-C", $RepoRoot,
        "-o", $lastMessageFile,
        "-"
    )

    if ($BypassSandbox) {
        $arguments += "--dangerously-bypass-approvals-and-sandbox"
    }
    else {
        $arguments += "--full-auto"
    }

    $attemptLimit = [Math]::Max(1, $CodexRetryCount)

    for ($attempt = 1; $attempt -le $attemptLimit; $attempt += 1) {
        $jsonLog = Join-Path $StateDirectory (("iteration-{0:D4}-attempt-{1:D2}.jsonl") -f $Iteration, $attempt)
        if (Test-Path -LiteralPath $lastMessageFile) {
            Remove-Item -LiteralPath $lastMessageFile -Force
        }

        Write-History ("Starting Codex iteration {0}, attempt {1} of {2}." -f $Iteration, $attempt, $attemptLimit)
        Push-Location $RepoRoot
        try {
            $prompt | & codex @arguments | Tee-Object -FilePath $jsonLog
            $exitCode = $LASTEXITCODE
        }
        finally {
            Pop-Location
        }

        if ($exitCode -eq 0 -and (Test-Path -LiteralPath $lastMessageFile)) {
            return Get-Content -LiteralPath $lastMessageFile -Raw
        }

        Write-History ("Codex iteration {0} attempt {1} failed with exit code {2}." -f $Iteration, $attempt, $exitCode)
    }

    throw ("Codex iteration {0} failed after {1} attempt(s)." -f $Iteration, $attemptLimit)
}

if ([string]::IsNullOrWhiteSpace($Repository)) {
    Push-Location $RepoRoot
    try {
        $remoteUrl = git remote get-url origin
    }
    finally {
        Pop-Location
    }
    $Repository = Get-RepositoryName -RemoteUrl $remoteUrl.Trim()
}

Write-History "Repo root: $RepoRoot"
Write-History "Repository: $Repository"
Write-History "Stop file: $stopFile"

if ($CloseCatchUpIssuesOnly) {
    Write-History "CloseCatchUpIssuesOnly was set, but automatic catch-up closure is disabled until issues have explicit resolution evidence. Exiting."
    exit 0
}

$idleIterations = 0
$iteration = 1

while ($true) {
    if ((Test-Path -LiteralPath $stopFile)) {
        Write-History "Stop file detected. Exiting loop."
        break
    }

    if ($MaxIterations -gt 0 -and $iteration -gt $MaxIterations) {
        Write-History ("Reached MaxIterations={0}. Exiting loop." -f $MaxIterations)
        break
    }

    $openIssues = Get-OpenRelatedIssues
    if ($openIssues.Count -eq 0) {
        Write-History "No open related issues remain. Exiting loop."
        break
    }

    $targetIssue = Get-TargetIssue -OpenIssues $openIssues -RequestedIssueNumber $IssueNumber
    if ($null -eq $targetIssue) {
        Write-History "No target issue could be selected. Exiting loop."
        break
    }

    Write-History ("Targeting issue #{0}: {1}" -f $targetIssue.number, $targetIssue.title)

    $beforeStatus = Get-StatusSnapshot
    $lastMessage = Invoke-CodexPass -Iteration $iteration -TargetIssue $targetIssue -OpenIssues $openIssues

    if (-not $SkipValidation) {
        Invoke-NarrowValidation
    }

    $reportedCompletedIssues = @(Get-CompletedIssueNumbersFromMessage -Message $lastMessage)

    if ($reportedCompletedIssues.Count -gt 0) {
        Write-History ("Codex reported completed issues: {0}" -f (($reportedCompletedIssues | Sort-Object) -join ", "))
    }
    else {
        Write-History "Codex did not report any completed issues."
    }

    $closedAfterPass = @(Close-VerifiedCompletedIssues -AllowedIssueNumbers $reportedCompletedIssues)
    $afterStatus = Get-StatusSnapshot

    $repoChanged = $beforeStatus -ne $afterStatus
    if ($repoChanged -or $closedAfterPass.Count -gt 0) {
        $idleIterations = 0
    }
    else {
        $idleIterations += 1
        Write-History ("No repo delta detected after iteration {0}. Idle count is now {1}." -f $iteration, $idleIterations)
    }

    if ($idleIterations -ge $IdleLimit) {
        Write-History ("Reached IdleLimit={0} with no repo delta. Exiting loop." -f $IdleLimit)
        break
    }

    $iteration += 1
}

Write-History "Codex driver stopped."