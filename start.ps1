# SinceLastBoot installer
# Copies the report scripts into the user profile and configures OpenSSH ForceCommand.

$ErrorActionPreference = 'Stop'

$SSHDConfigPath = "C:\ProgramData\ssh\sshd_config"
$BackupPath = "$SSHDConfigPath.bak"

function Write-Status {
    param([string]$Message, [string]$Color = 'White')
    Write-Host $Message -ForegroundColor $Color
}

# --- Validate OpenSSH ---
if (-not (Test-Path $SSHDConfigPath)) {
    Write-Status "sshd_config not found. Install and configure OpenSSH Server first." Red
    exit 1
}

# --- Backup ---
try {
    Copy-Item -Path $SSHDConfigPath -Destination $BackupPath -Force
    Write-Status "Backup created: $BackupPath" Green
} catch {
    Write-Status "Failed to back up sshd_config: $_" Red
    exit 1
}

# --- Update ForceCommand ---
$lines = Get-Content -Path $SSHDConfigPath

# Remove any existing ForceCommand lines (simple and reliable)
$cleaned = $lines | Where-Object { $_ -notmatch '^\s*ForceCommand\s+' }

$forceCommand = 'ForceCommand powershell.exe -NoExit -Command "& { . \"$env:USERPROFILE\report.ps1\"; . \"$env:USERPROFILE\reportexport.ps1\" }"'
$cleaned += $forceCommand

try {
    $cleaned | Set-Content -Path $SSHDConfigPath -Force -Encoding UTF8
    Write-Status "sshd_config updated with ForceCommand." Green
} catch {
    Write-Status "Failed to write sshd_config: $_" Red
    exit 1
}

# --- Copy report scripts ---
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$srcReport   = Join-Path $scriptDir "ds1"
$srcExport   = Join-Path $scriptDir "ds2"

$destReport  = Join-Path $env:USERPROFILE "report.ps1"
$destExport  = Join-Path $env:USERPROFILE "reportexport.ps1"

if (-not (Test-Path $srcReport) -or -not (Test-Path $srcExport)) {
    Write-Status "Source scripts ds1/ds2 not found next to start.ps1." Red
    exit 1
}

Copy-Item -Path $srcReport -Destination $destReport -Force
Copy-Item -Path $srcExport -Destination $destExport -Force
Write-Status "Report scripts installed to $env:USERPROFILE" Green

# --- Restart SSH ---
try {
    Restart-Service sshd -ErrorAction Stop
    Write-Status "OpenSSH service restarted." Green
} catch {
    Write-Status "Could not restart sshd automatically. Restart it manually." Yellow
}

# --- Cleanup ---
& (Join-Path $scriptDir "cleanup.ps1")

Write-Status "Installation complete. SSH logins will now show the SinceLastBoot report." Green
