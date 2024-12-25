# Define the path to the sshd_config file
$SSHDConfigPath = "C:\ProgramData\ssh\sshd_config"
$BackupPath = "$SSHDConfigPath.bak"

# Check if the sshd_config file exists
if (-not (Test-Path $SSHDConfigPath)) {
    Write-Host "sshd_config file not found. Please ensure OpenSSH is properly configured." -ForegroundColor Red
    exit
}

# Create a backup of the sshd_config file
try {
    Copy-Item -Path $SSHDConfigPath -Destination $BackupPath -Force
    Write-Host "Backup of sshd_config created successfully at $BackupPath" -ForegroundColor Green
} catch {
    Write-Host "Failed to create backup. Exiting script. Error: $_" -ForegroundColor Red
    exit
}

# Read the content of the sshd_config file
$SSHDConfigContent = Get-Content -Path $SSHDConfigPath

# Check and remove lines containing "ForceCommand" in the last two lines
$UpdatedContent = $SSHDConfigContent |
    Where-Object { $_ -notmatch "ForceCommand" -or ($_ -ne $SSHDConfigContent[-1] -and $_ -ne $SSHDConfigContent[-2]) }

# Add the new ForceCommand directive
$ForceCommand = 'ForceCommand powershell.exe -NoExit -Command "& { . \"$env:USERPROFILE\report.ps1\"; . \"$env:USERPROFILE\reportexport.ps1\" }"'
$UpdatedContent += $ForceCommand

# Write the updated content back to sshd_config
try {
    Set-Content -Path $SSHDConfigPath -Value $UpdatedContent -Force
    Write-Host "Updated sshd_config successfully with new ForceCommand directive." -ForegroundColor Green
} catch {
    Write-Host "Failed to update sshd_config. Error: $_" -ForegroundColor Red
    exit
}

# Inform user of completion
Write-Host "sshd_config has been updated. Please restart the SSH service to apply changes." -ForegroundColor Yellow
