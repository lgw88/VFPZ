param(
    [string]$OutputDirectory = "docs/generated",
    [string[]]$InstalledVfpRoots = @(
        "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples",
        "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards",
        "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Ffc",
        "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Tools"
    ),
    [string[]]$VfpSourceRoots = @(
        "E:\VFPSource"
    ),
    [string[]]$LegacyProjectRoots = @(),
    [string[]]$RegressionSampleRoots = @()
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$supportedAssetTypes = @{
    ".app" = "APP"
    ".cdx" = "CDX"
    ".dbc" = "DBC"
    ".dbf" = "DBF"
    ".dct" = "DCT"
    ".dcx" = "DCX"
    ".frt" = "FRT"
    ".frx" = "FRX"
    ".fpt" = "FPT"
    ".fxp" = "FXP"
    ".h" = "H"
    ".idx" = "IDX"
    ".mnt" = "MNT"
    ".mnx" = "MNX"
    ".mpr" = "MPR"
    ".pjt" = "PJT"
    ".pjx" = "PJX"
    ".prg" = "PRG"
    ".qpr" = "QPR"
    ".sct" = "SCT"
    ".scx" = "SCX"
    ".spr" = "SPR"
    ".vct" = "VCT"
    ".vcx" = "VCX"
}

function Resolve-OutputRoot {
    param([string]$Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path -Path (Get-Location) -ChildPath $Path))
}

function Get-RelativePathCompat {
    param(
        [string]$RootPath,
        [string]$TargetPath
    )

    if ([string]::IsNullOrWhiteSpace($RootPath) -or [string]::IsNullOrWhiteSpace($TargetPath)) {
        return $TargetPath
    }

    $fullRoot = [System.IO.Path]::GetFullPath($RootPath)
    $fullTarget = [System.IO.Path]::GetFullPath($TargetPath)
    $pathType = [System.IO.Path]
    $getRelativePath = $pathType.GetMethod("GetRelativePath", [type[]]@([string], [string]))
    if ($null -ne $getRelativePath) {
        return $getRelativePath.Invoke($null, @($fullRoot, $fullTarget))
    }

    $rootUri = New-Object System.Uri(($fullRoot.TrimEnd('\') + '\'))
    $targetUri = New-Object System.Uri($fullTarget)
    return [System.Uri]::UnescapeDataString(
        $rootUri.MakeRelativeUri($targetUri).ToString().Replace('/', '\'))
}

function Get-AssetCategory {
    param([string]$AssetType)

    switch ($AssetType) {
        { $_ -in @("PRG", "H", "QPR", "MPR", "SPR", "FXP") } { return "code" }
        { $_ -in @("SCX", "SCT", "VCX", "VCT", "FRX", "FRT", "MNX", "MNT") } { return "designer" }
        { $_ -in @("DBF", "FPT", "CDX", "IDX", "DBC", "DCX", "DCT") } { return "data" }
        { $_ -in @("PJX", "PJT", "APP") } { return "application" }
        default { return "other" }
    }
}

function New-CorpusEntry {
    param(
        [string]$SourceKind,
        [string]$RootPath,
        [System.IO.FileInfo]$FileInfo
    )

    $assetType = $supportedAssetTypes[$FileInfo.Extension.ToLowerInvariant()]
    if (-not $assetType) {
        return $null
    }

    $relativePath = Get-RelativePathCompat -RootPath $RootPath -TargetPath $FileInfo.FullName
    return [pscustomobject]@{
        sourceKind = $SourceKind
        rootPath = $RootPath
        relativePath = $relativePath
        filePath = $FileInfo.FullName
        assetType = $assetType
        assetCategory = Get-AssetCategory -AssetType $assetType
        sizeBytes = $FileInfo.Length
    }
}

function Add-CorpusEntriesForRoots {
    param(
        [string]$SourceKind,
        [string[]]$Roots,
        [System.Collections.Generic.List[object]]$Entries,
        [System.Collections.Generic.List[object]]$MissingRoots,
        [System.Collections.Generic.List[object]]$IncludedRoots
    )

    foreach ($root in $Roots) {
        if ([string]::IsNullOrWhiteSpace($root)) {
            continue
        }

        $rootPath = [System.IO.Path]::GetFullPath($root)
        if (-not (Test-Path -LiteralPath $rootPath)) {
            $MissingRoots.Add([pscustomobject]@{
                sourceKind = $SourceKind
                rootPath = $rootPath
            })
            continue
        }

        $rootItem = Get-Item -LiteralPath $rootPath
        $IncludedRoots.Add([pscustomobject]@{
            sourceKind = $SourceKind
            rootPath = $rootPath
        })

        if ($rootItem -is [System.IO.FileInfo]) {
            $entry = New-CorpusEntry -SourceKind $SourceKind -RootPath $rootItem.DirectoryName -FileInfo $rootItem
            if ($null -ne $entry) {
                $Entries.Add($entry)
            }
            continue
        }

        Get-ChildItem -LiteralPath $rootPath -Recurse -File | ForEach-Object {
            $entry = New-CorpusEntry -SourceKind $SourceKind -RootPath $rootPath -FileInfo $_
            if ($null -ne $entry) {
                $Entries.Add($entry)
            }
        }
    }
}

$entries = New-Object System.Collections.Generic.List[object]
$includedRoots = New-Object System.Collections.Generic.List[object]
$missingRoots = New-Object System.Collections.Generic.List[object]

Add-CorpusEntriesForRoots -SourceKind "installed-vfp" -Roots $InstalledVfpRoots -Entries $entries -MissingRoots $missingRoots -IncludedRoots $includedRoots
Add-CorpusEntriesForRoots -SourceKind "local-vfp-source" -Roots $VfpSourceRoots -Entries $entries -MissingRoots $missingRoots -IncludedRoots $includedRoots
Add-CorpusEntriesForRoots -SourceKind "legacy-project" -Roots $LegacyProjectRoots -Entries $entries -MissingRoots $missingRoots -IncludedRoots $includedRoots
Add-CorpusEntriesForRoots -SourceKind "regression-sample" -Roots $RegressionSampleRoots -Entries $entries -MissingRoots $missingRoots -IncludedRoots $includedRoots

$outputRoot = Resolve-OutputRoot -Path $OutputDirectory
if (-not (Test-Path -LiteralPath $outputRoot)) {
    New-Item -Path $outputRoot -ItemType Directory | Out-Null
}

$sortedEntries = $entries | Sort-Object sourceKind, rootPath, relativePath

$countsBySourceKind = [ordered]@{}
foreach ($group in ($sortedEntries | Group-Object sourceKind | Sort-Object Name)) {
    $countsBySourceKind[$group.Name] = $group.Count
}

$countsByAssetType = [ordered]@{}
foreach ($group in ($sortedEntries | Group-Object assetType | Sort-Object Name)) {
    $countsByAssetType[$group.Name] = $group.Count
}

$countsByAssetCategory = [ordered]@{}
foreach ($group in ($sortedEntries | Group-Object assetCategory | Sort-Object Name)) {
    $countsByAssetCategory[$group.Name] = $group.Count
}

$summary = [pscustomobject]@{
    generatedAtUtc = [DateTime]::UtcNow.ToString("o")
    requestedRoots = [pscustomobject]@{
        installedVfp = $InstalledVfpRoots
        vfpSource = $VfpSourceRoots
        legacyProjects = $LegacyProjectRoots
        regressionSamples = $RegressionSampleRoots
    }
    includedRoots = @($includedRoots | Sort-Object sourceKind, rootPath)
    missingRoots = @($missingRoots | Sort-Object sourceKind, rootPath)
    totalEntries = @($sortedEntries).Count
    countsBySourceKind = $countsBySourceKind
    countsByAssetType = $countsByAssetType
    countsByAssetCategory = $countsByAssetCategory
}

$sortedEntries | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-compatibility-corpus.json") -Encoding utf8
$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $outputRoot "vfp-compatibility-corpus-summary.json") -Encoding utf8

Write-Output ("Wrote {0} corpus entries across {1} roots to {2}" -f ($sortedEntries.Count), ($includedRoots.Count), $outputRoot)
