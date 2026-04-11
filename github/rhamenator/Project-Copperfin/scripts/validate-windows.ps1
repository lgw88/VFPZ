$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$buildDir = Join-Path $repoRoot "build"
$vsixDir = Join-Path $repoRoot "vsix"
$nativeProject = $repoRoot
$vsixProject = Join-Path $vsixDir "Copperfin.VisualStudio\Copperfin.VisualStudio.csproj"
$studioProject = Join-Path $vsixDir "Copperfin.Studio\Copperfin.Studio.csproj"
$smokeProject = Join-Path $vsixDir "Copperfin.DesignerSmokeTests\Copperfin.DesignerSmokeTests.csproj"
$smokeExe = Join-Path $vsixDir "Copperfin.DesignerSmokeTests\bin\Release\net472\Copperfin.DesignerSmokeTests.exe"
$sampleProject = "C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\solution.pjx"
$runtimeSmokeRoot = Join-Path $repoRoot "artifacts\runtime-smoke-validation"
$buildHostExe = Join-Path $buildDir "Release\copperfin_build_host.exe"
$runtimeHostExe = Join-Path $buildDir "Release\copperfin_runtime_host.exe"

function Invoke-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [scriptblock]$Action
    )

    Write-Host ""
    Write-Host "==> $Name" -ForegroundColor Cyan
    & $Action
}

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [string[]]$ArgumentList = @()
    )

    & $FilePath @ArgumentList
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed: $FilePath $($ArgumentList -join ' ')"
    }
}

function Resolve-MSBuild {
    $command = Get-Command MSBuild.exe -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }

    $vswhere = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path $vswhere) {
        $resolved = & $vswhere -latest -requires Microsoft.Component.MSBuild -find "MSBuild\**\Bin\MSBuild.exe" | Select-Object -First 1
        if (-not [string]::IsNullOrWhiteSpace($resolved)) {
            return $resolved
        }
    }

    throw "MSBuild.exe could not be located. Install Visual Studio Build Tools or run from a Developer PowerShell."
}

$msbuild = Resolve-MSBuild

Invoke-Step -Name "Configure native build" -Action {
    Invoke-Checked -FilePath "cmake" -ArgumentList @("-S", $nativeProject, "-B", $buildDir)
}

Invoke-Step -Name "Build native binaries" -Action {
    Invoke-Checked -FilePath "cmake" -ArgumentList @("--build", $buildDir, "--config", "Release")
}

Invoke-Step -Name "Run native CTest suite" -Action {
    Invoke-Checked -FilePath "ctest" -ArgumentList @("--test-dir", $buildDir, "-C", "Release", "--output-on-failure")
}

Invoke-Step -Name "Build Visual Studio extension" -Action {
    Invoke-Checked -FilePath $msbuild -ArgumentList @($vsixProject, "/restore", "/t:Rebuild", "/p:Configuration=Release", "/p:DeployExtension=false")
}

Invoke-Step -Name "Build standalone Studio shell" -Action {
    Invoke-Checked -FilePath $msbuild -ArgumentList @($studioProject, "/restore", "/t:Rebuild", "/p:Configuration=Release")
}

Invoke-Step -Name "Build designer smoke tests" -Action {
    Invoke-Checked -FilePath $msbuild -ArgumentList @($smokeProject, "/restore", "/t:Rebuild", "/p:Configuration=Release")
}

Invoke-Step -Name "Run designer smoke tests" -Action {
    Invoke-Checked -FilePath $smokeExe
}

Invoke-Step -Name "Run runtime package smoke test" -Action {
    Remove-Item -Recurse -Force $runtimeSmokeRoot -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $runtimeSmokeRoot | Out-Null

    Invoke-Checked -FilePath $buildHostExe -ArgumentList @(
        "build",
        "--project", $sampleProject,
        "--output-dir", $runtimeSmokeRoot,
        "--configuration", "debug",
        "--enable-security",
        "--emit-dotnet-launcher",
        "--runtime-host", $runtimeHostExe
    )

    $packagedRoot = Join-Path $runtimeSmokeRoot "SOLUTION"
    $launcherExe = Join-Path $packagedRoot "SOLUTION.exe"
    $manifestPath = Join-Path $packagedRoot "app.cfmanifest"

    if (-not (Test-Path $launcherExe)) {
        throw "Expected generated launcher was not found: $launcherExe"
    }
    if (-not (Test-Path $manifestPath)) {
        throw "Expected runtime manifest was not found: $manifestPath"
    }

    Invoke-Checked -FilePath $launcherExe -ArgumentList @("--debug")
}

Invoke-Step -Name "Run PRG debugger smoke test" -Action {
    $prgSmokeRoot = Join-Path $repoRoot "artifacts\prg-debug-smoke"
    Remove-Item -Recurse -Force $prgSmokeRoot -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $prgSmokeRoot | Out-Null

    $prgPath = Join-Path $prgSmokeRoot "main.prg"
    @(
        "x = 1",
        "DO localproc",
        "x = x + 1",
        "RETURN",
        "PROCEDURE localproc",
        "x = x + 2",
        "RETURN"
    ) | Set-Content -Path $prgPath

    $manifestPath = Join-Path $prgSmokeRoot "app.cfmanifest"
    @(
        "manifest_version=1",
        "project_title=PRGDEBUG",
        "project_path=E:\Project-Copperfin\smoke.pjx",
        "package_root=$prgSmokeRoot",
        "content_root=$prgSmokeRoot",
        "working_directory=$prgSmokeRoot",
        "startup_item=main.prg",
        "startup_source=$prgPath",
        "configuration=debug",
        "security_enabled=false",
        "security_mode=off",
        "dotnet_enabled=false",
        "dotnet_story="
    ) | Set-Content -Path $manifestPath

    Invoke-Checked -FilePath $runtimeHostExe -ArgumentList @(
        "--manifest", $manifestPath,
        "--debug",
        "--breakpoint", "2",
        "--debug-command", "continue",
        "--debug-command", "step",
        "--debug-command", "out",
        "--debug-command", "continue"
    )
}

Invoke-Step -Name "Run xAsset bootstrap smoke test" -Action {
    $xassetSmokeRoot = Join-Path $repoRoot "artifacts\xasset-debug-smoke"
    Remove-Item -Recurse -Force $xassetSmokeRoot -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $xassetSmokeRoot | Out-Null

    $manifestPath = Join-Path $xassetSmokeRoot "app.cfmanifest"
    @(
        "manifest_version=1",
        "project_title=XASSETDEBUG",
        "project_path=E:\Project-Copperfin\xasset-smoke.pjx",
        "package_root=$xassetSmokeRoot",
        "content_root=$xassetSmokeRoot",
        "working_directory=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards\Template\Books\Forms",
        "startup_item=books.scx",
        "startup_source=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Wizards\Template\Books\Forms\books.scx",
        "configuration=debug",
        "security_enabled=false",
        "security_mode=off",
        "dotnet_enabled=false",
        "dotnet_story="
    ) | Set-Content -Path $manifestPath

    Invoke-Checked -FilePath $runtimeHostExe -ArgumentList @(
        "--manifest", $manifestPath,
        "--debug",
        "--debug-command", "continue",
        "--debug-command", "invoke:frmbooks.release"
    )
}

Invoke-Step -Name "Run report xAsset smoke test" -Action {
    $reportSmokeRoot = Join-Path $repoRoot "artifacts\report-debug-smoke"
    Remove-Item -Recurse -Force $reportSmokeRoot -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $reportSmokeRoot | Out-Null

    $manifestPath = Join-Path $reportSmokeRoot "app.cfmanifest"
    @(
        "manifest_version=1",
        "project_title=REPORTDEBUG",
        "project_path=E:\Project-Copperfin\report-smoke.pjx",
        "package_root=$reportSmokeRoot",
        "content_root=$reportSmokeRoot",
        "working_directory=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Reports",
        "startup_item=invoice.frx",
        "startup_source=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Reports\invoice.frx",
        "configuration=debug",
        "security_enabled=false",
        "security_mode=off",
        "dotnet_enabled=false",
        "dotnet_story="
    ) | Set-Content -Path $manifestPath

    Invoke-Checked -FilePath $runtimeHostExe -ArgumentList @(
        "--manifest", $manifestPath,
        "--debug",
        "--debug-command", "continue"
    )
}

Invoke-Step -Name "Run menu xAsset smoke test" -Action {
    $menuSmokeRoot = Join-Path $repoRoot "artifacts\menu-debug-smoke"
    Remove-Item -Recurse -Force $menuSmokeRoot -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Force $menuSmokeRoot | Out-Null

    $manifestPath = Join-Path $menuSmokeRoot "app.cfmanifest"
    @(
        "manifest_version=1",
        "project_title=MENUDEBUG",
        "project_path=E:\Project-Copperfin\menu-smoke.pjx",
        "package_root=$menuSmokeRoot",
        "content_root=$menuSmokeRoot",
        "working_directory=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Toledo",
        "startup_item=systray_shortcut.mnx",
        "startup_source=C:\Program Files (x86)\Microsoft Visual FoxPro 9\Samples\Solution\Toledo\systray_shortcut.mnx",
        "configuration=debug",
        "security_enabled=false",
        "security_mode=off",
        "dotnet_enabled=false",
        "dotnet_story="
    ) | Set-Content -Path $manifestPath

    Invoke-Checked -FilePath $runtimeHostExe -ArgumentList @(
        "--manifest", $manifestPath,
        "--debug",
        "--debug-command", "continue",
        "--debug-command", "select:shortcut.item1",
        "--debug-command", "select:shortcut.item3",
        "--debug-command", "select:thisitemha.item3"
    )
}

Write-Host ""
Write-Host "Validation complete." -ForegroundColor Green
