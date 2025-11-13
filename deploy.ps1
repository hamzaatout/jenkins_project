param(
    [string]$VirtualEnv = "venv"
)

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$venvPython = Join-Path -Path $projectRoot -ChildPath ("{0}\Scripts\python.exe" -f $VirtualEnv)
$appPath = Join-Path -Path $projectRoot -ChildPath "app.py"
$outputPath = Join-Path -Path $projectRoot -ChildPath "deployment_output.txt"

if (Test-Path $venvPython) {
    $pythonExe = $venvPython
} else {
    Write-Host "Virtual environment executable not found. Falling back to system python."
    $pythonExe = "python"
}

$deployOutput = & $pythonExe $appPath
$deployOutput | Out-File -FilePath $outputPath -Encoding ascii
Write-Host "Application deployed locally. Output saved to $outputPath"
