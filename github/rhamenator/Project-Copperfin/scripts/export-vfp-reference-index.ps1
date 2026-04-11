param(
    [string]$OutputDirectory = "docs/generated"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$languageReferenceUrl = "https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/dd5f4hyy(v=vs.71)"
$generalReferenceUrl = "https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/h9f898ae(v=vs.71)"
$vfpHomeUrl = "https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/mt490117(v=msdn.10)"
$foxpro26HelpPath = "C:\vDosPlus\FPD26\FOXHELP.DBF"
$baseReferenceUrl = "https://learn.microsoft.com/en-us/previous-versions/visualstudio/foxpro/"

function Normalize-HtmlText {
    param([string]$Text)

    $value = $Text -replace "<.*?>", " "
    $value = $value -replace "&amp;", "&"
    $value = $value -replace "&lt;", "<"
    $value = $value -replace "&gt;", ">"
    $value = $value -replace "&nbsp;", " "
    $value = $value -replace "&#39;", "'"
    $value = $value -replace "&quot;", '"'
    $value = $value -replace "\s+", " "
    return $value.Trim()
}

function Get-EntryCategory {
    param([string]$Text)

    if ($Text -match " Command$") { return "Command" }
    if ($Text -match " Function$") { return "Function" }
    if ($Text -match " Event$") { return "Event" }
    if ($Text -match " Method$") { return "Method" }
    if ($Text -match " Property$| Properties$") { return "Property" }
    if ($Text -match " Object$") { return "Object" }
    if ($Text -match " System Variable$") { return "SystemVariable" }
    if ($Text -match "Preprocessor Directive$") { return "PreprocessorDirective" }
    if ($Text -match " Operator$") { return "Operator" }
    return "Other"
}

function Resolve-ReferenceUrl {
    param([string]$Href)

    if ($Href -match "^https?://") {
        return $Href
    }

    return $baseReferenceUrl + $Href
}

$response = Invoke-WebRequest -UseBasicParsing -Uri $languageReferenceUrl
$matches = [regex]::Matches(
    $response.Content,
    '<a[^>]+href="([^"]+foxpro/[^"]+|[^"]+\(v=vs\.71\))"[^>]*>(.*?)</a>',
    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
    [System.Text.RegularExpressions.RegexOptions]::Singleline)

$seen = @{}
$entries = New-Object System.Collections.Generic.List[object]

foreach ($match in $matches) {
    $text = Normalize-HtmlText $match.Groups[2].Value
    if ([string]::IsNullOrWhiteSpace($text)) {
        continue
    }

    if ($seen.ContainsKey($text)) {
        continue
    }
    $seen[$text] = $true

    $href = $match.Groups[1].Value
    $entries.Add([pscustomobject]@{
        text = $text
        category = Get-EntryCategory $text
        href = $href
        url = Resolve-ReferenceUrl $href
    })
}

$outputRoot = Join-Path -Path (Get-Location) -ChildPath $OutputDirectory
if (-not (Test-Path $outputRoot)) {
    New-Item -Path $outputRoot -ItemType Directory | Out-Null
}

$commands = $entries | Where-Object { $_.category -eq "Command" } | Sort-Object text
$counts = [ordered]@{}
foreach ($group in ($entries | Group-Object category | Sort-Object Name)) {
    $counts[$group.Name] = $group.Count
}

$summary = [pscustomobject]@{
    generatedAtUtc = [DateTime]::UtcNow.ToString("o")
    sources = [pscustomobject]@{
        languageReference = $languageReferenceUrl
        generalReference = $generalReferenceUrl
        vfpHome = $vfpHomeUrl
        foxpro26HelpDbf = $foxpro26HelpPath
    }
    counts = $counts
    totalEntries = $entries.Count
    commandEntries = $commands.Count
}

$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-language-reference-summary.json")
$commands | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-language-reference-commands.json")
($commands | ForEach-Object { $_.text }) | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-language-reference-commands.txt")

Write-Output ("Wrote summary for {0} entries and {1} commands to {2}" -f $entries.Count, $commands.Count, $outputRoot)
