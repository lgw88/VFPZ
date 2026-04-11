param(
    [string]$InstallRoot = "C:\Program Files (x86)\Microsoft Visual FoxPro 9",
    [string]$OutputDirectory = "docs/generated"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Decode-HtmlValue {
    param([string]$Value)

    $decoded = $Value -replace "&amp;", "&"
    $decoded = $decoded -replace "&lt;", "<"
    $decoded = $decoded -replace "&gt;", ">"
    $decoded = $decoded -replace "&nbsp;", " "
    $decoded = $decoded -replace "&#39;", "'"
    $decoded = $decoded -replace "&quot;", '"'
    return ($decoded -replace "\s+", " ").Trim()
}

function Parse-SitemapFile {
    param([string]$Path)

    $content = Get-Content -LiteralPath $Path -Raw
    $objects = [regex]::Matches(
        $content,
        '<object\s+type="text/sitemap">(.*?)</object>',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
        [System.Text.RegularExpressions.RegexOptions]::Singleline)

    $entries = New-Object System.Collections.Generic.List[object]

    foreach ($object in $objects) {
        $block = $object.Groups[1].Value
        $keywordMatches = [regex]::Matches(
            $block,
            '<param\s+name="Keyword"\s+value="([^"]*)"\s*/?>',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        $localMatch = [regex]::Match(
            $block,
            '<param\s+name="Local"\s+value="([^"]*)"\s*/?>',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        $nameMatch = [regex]::Match(
            $block,
            '<param\s+name="Name"\s+value="([^"]*)"\s*/?>',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

        $local = if ($localMatch.Success) { Decode-HtmlValue $localMatch.Groups[1].Value } else { "" }
        $topicName = if ($nameMatch.Success) { Decode-HtmlValue $nameMatch.Groups[1].Value } else { "" }

        foreach ($keywordMatch in $keywordMatches) {
            $keyword = Decode-HtmlValue $keywordMatch.Groups[1].Value
            if ([string]::IsNullOrWhiteSpace($keyword)) {
                continue
            }

            $entries.Add([pscustomobject]@{
                keyword = $keyword
                local = $local
                topicName = $topicName
            })
        }
    }

    return $entries
}

function Get-TopicTitle {
    param(
        [string]$ExtractRoot,
        [string]$LocalPath
    )

    if ([string]::IsNullOrWhiteSpace($LocalPath)) {
        return ""
    }

    $path = Join-Path $ExtractRoot $LocalPath
    if (-not (Test-Path -LiteralPath $path)) {
        return ""
    }

    $content = Get-Content -LiteralPath $path -Raw
    $titleMatch = [regex]::Match(
        $content,
        '<title>(.*?)</title>',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
        [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($titleMatch.Success) {
        return Decode-HtmlValue $titleMatch.Groups[1].Value
    }

    $headingMatch = [regex]::Match(
        $content,
        '<h1[^>]*>(.*?)</h1>',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
        [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($headingMatch.Success) {
        return Decode-HtmlValue ($headingMatch.Groups[1].Value -replace '<[^>]+>', ' ')
    }

    return ""
}

function Guess-TopicKind {
    param(
        [string]$Keyword,
        [string]$ChmName
    )

    if ($Keyword -match ' Command$') {
        return "command"
    }
    if ($Keyword -match ' Function$' -or $Keyword -match '\(\s*\)$') {
        return "function"
    }
    if ($Keyword -match ' Property$') {
        return "property"
    }
    if ($Keyword -match ' Method$') {
        return "method"
    }
    if ($Keyword -match ' Event$') {
        return "event"
    }
    if ($Keyword -match ' API library routine$') {
        return "api-routine"
    }
    if ($ChmName -ieq 'foxtools.chm') {
        return "foxtools"
    }
    return "topic"
}

$outputRoot = Join-Path -Path (Get-Location) -ChildPath $OutputDirectory
if (-not (Test-Path -LiteralPath $outputRoot)) {
    New-Item -Path $outputRoot -ItemType Directory | Out-Null
}

$tempRoot = Join-Path $env:TEMP "copperfin-vfp-chm-index"
if (-not (Test-Path -LiteralPath $tempRoot)) {
    New-Item -Path $tempRoot -ItemType Directory | Out-Null
}

$chmFiles = Get-ChildItem -LiteralPath $InstallRoot -Filter *.chm | Sort-Object Name
$summary = New-Object System.Collections.Generic.List[object]
$manifest = New-Object System.Collections.Generic.List[object]
$commandTopics = New-Object System.Collections.Generic.List[object]
$foxtoolsTopics = New-Object System.Collections.Generic.List[object]

foreach ($chm in $chmFiles) {
    $extractRoot = Join-Path $tempRoot $chm.BaseName
    Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -Path $extractRoot -ItemType Directory | Out-Null

    Start-Process -FilePath "C:\Windows\hh.exe" -ArgumentList @("-decompile", $extractRoot, $chm.FullName) -Wait -WindowStyle Hidden

    $hhk = Get-ChildItem -LiteralPath $extractRoot -Filter *.hhk | Select-Object -First 1
    $hhc = Get-ChildItem -LiteralPath $extractRoot -Filter *.hhc | Select-Object -First 1
    if (-not $hhk) {
        continue
    }

    $entries = Parse-SitemapFile -Path $hhk.FullName
    foreach ($entry in $entries) {
        $kind = Guess-TopicKind -Keyword $entry.keyword -ChmName $chm.Name
        $title = Get-TopicTitle -ExtractRoot $extractRoot -LocalPath $entry.local
        $record = [pscustomobject]@{
            chm = $chm.Name
            sourcePath = $chm.FullName
            keyword = $entry.keyword
            local = $entry.local
            topicName = $entry.topicName
            title = $title
            kind = $kind
        }

        $manifest.Add($record)
        if ($kind -eq "command") {
            $commandTopics.Add($record)
        }
        if ($chm.Name -ieq "foxtools.chm") {
            $foxtoolsTopics.Add($record)
        }
    }

    $summary.Add([pscustomobject]@{
        chm = $chm.Name
        sourcePath = $chm.FullName
        hhk = if ($hhk) { $hhk.Name } else { "" }
        hhc = if ($hhc) { $hhc.Name } else { "" }
        topicEntries = @($entries).Count
        commandEntries = @($manifest | Where-Object { $_.chm -eq $chm.Name -and $_.kind -eq 'command' }).Count
        functionEntries = @($manifest | Where-Object { $_.chm -eq $chm.Name -and $_.kind -eq 'function' }).Count
        foxtoolsEntries = @($manifest | Where-Object { $_.chm -eq $chm.Name -and $_.kind -eq 'foxtools' }).Count
    })
}

$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-chm-index-summary.json") -Encoding utf8
$commandTopics | Sort-Object keyword, local | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-chm-command-topics.json") -Encoding utf8
$foxtoolsTopics | Sort-Object keyword, local | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-foxtools-topics.json") -Encoding utf8
$manifest | Sort-Object chm, kind, keyword, local | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-chm-topic-manifest.json") -Encoding utf8

Write-Output ("Indexed {0} CHM files, {1} topics, {2} command topics, and {3} foxtools topics" -f $summary.Count, $manifest.Count, $commandTopics.Count, $foxtoolsTopics.Count)
