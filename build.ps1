param(
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release",
    [string]$TavernLibRoot = ""
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($TavernLibRoot)) {
    $TavernLibRoot = Join-Path (Split-Path -Parent $root) "FlatscreenATTMod\TavernLib-main"
}

$dependencies = Join-Path $TavernLibRoot "Dependencies"
$output = Join-Path $root "bin\$Configuration"
$compiler = "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe"

if (!(Test-Path $compiler)) {
    throw "Could not find .NET Framework compiler at $compiler"
}

if (!(Test-Path (Join-Path $dependencies "MelonLoader.dll"))) {
    throw "Could not find TavernLib dependencies at $dependencies"
}

New-Item -ItemType Directory -Force -Path $output | Out-Null

& $compiler `
    /target:library `
    /out:"$output\MiniMapMod.dll" `
    /reference:"$dependencies\MelonLoader.dll" `
    /reference:"$dependencies\Unity.InputSystem.dll" `
    /reference:"$dependencies\UnityEngine.dll" `
    /reference:"$dependencies\UnityEngine.CoreModule.dll" `
    /reference:"$dependencies\UnityEngine.IMGUIModule.dll" `
    /reference:"$TavernLibRoot\Generated\Root.Township-publicized.dll" `
    "$root\Source\MinimapMod.cs"

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host "Built $output\MiniMapMod.dll"
