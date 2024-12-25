# Define file paths to delete
$filesToDelete = @(
    "C:\path\to\ds1",  # Replace with the actual path to ds1
    "C:\path\to\ds2",  # Replace with the actual path to ds2
    "C:\path\to\start.ps1"  # Replace with the actual path to start.ps1
)

# Delete files without notice
foreach ($file in $filesToDelete) {
    if (Test-Path -Path $file) {
        Remove-Item -Path $file -Force -Recurse
    }
}

# Define paths for scripts to run
$script1 = Join-Path $env:USERPROFILE "report.ps1"
$script2 = Join-Path $env:USERPROFILE "reportexport.ps1"

# Create a function that runs both scripts
function SinceLastBoot {
    if (Test-Path -Path $script1) {
        & $script1
    } else {
        Write-Host "Script 1 not found: $script1"
    }

    if (Test-Path -Path $script2) {
        & $script2
    } else {
        Write-Host "Script 2 not found: $script2"
    }
}

# Register the function as a system alias
Set-Alias -Name SinceLastBoot -Value SinceLastBoot

Write-Host "Cleanup complete and alias 'SinceLastBoot' created."

# Self-delete the script
try {
    $currentScript = $MyInvocation.MyCommand.Path
    Start-Sleep -Seconds 2 # Delay to ensure the script finishes execution
    Remove-Item -Path $currentScript -Force
    Write-Host "Self-deletion complete: $currentScript"
} catch {
    Write-Host "Failed to delete the script: $_" -ForegroundColor Red
}
