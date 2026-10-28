# SinceLastBoot cleanup
# Removes installer files and registers the SinceLastBoot alias for the current user.

$ErrorActionPreference = 'Continue'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$filesToDelete = @(
    (Join-Path $scriptDir "ds1"),
    (Join-Path $scriptDir "ds2"),
    (Join-Path $scriptDir "start.ps1")
)

foreach ($file in $filesToDelete) {
    if (Test-Path $file) {
        Remove-Item -Path $file -Force -Recurse -ErrorAction SilentlyContinue
    }
}

# Register alias in the current user's PowerShell profile so it persists
$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir  = Split-Path $profilePath -Parent

if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

$aliasBlock = @'

function SinceLastBoot {
    $report = Join-Path $env:USERPROFILE "report.ps1"
    $export = Join-Path $env:USERPROFILE "reportexport.ps1"
    if (Test-Path $report) { . $report }
    if (Test-Path $export) { . $export }
}

Set-Alias -Name SinceLastBoot -Value SinceLastBoot -Scope Global -Force
'@

# Append only if not already present
if (-not (Test-Path $profilePath) -or -not (Select-String -Path $profilePath -Pattern 'function SinceLastBoot' -Quiet)) {
    Add-Content -Path $profilePath -Value $aliasBlock
    Write-Host "Alias 'SinceLastBoot' added to PowerShell profile." -ForegroundColor Green
} else {
    Write-Host "Alias already present in profile." -ForegroundColor Yellow
}

# Self-delete
try {
    $me = $MyInvocation.MyCommand.Path
    if ($me -and (Test-Path $me)) {
        Start-Sleep -Seconds 1
        Remove-Item -Path $me -Force -ErrorAction SilentlyContinue
    }
} catch {}

Write-Host "Cleanup finished." -ForegroundColor Green
