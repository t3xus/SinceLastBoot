# Define the output report file
$Date = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
$ReportFilePath = "$env:USERPROFILE\Desktop\System_Report_$Date.html"

# Helper function for formatted output
function Write-HTMLSection {
    param (
        [string]$Title,
        [string]$Content
    )
    return @"
<h2>$Title</h2>
<pre>$Content</pre>
"@
}

# Initialize the HTML report
@"
<!DOCTYPE html>
<html>
<head>
    <title>System Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        pre { background-color: #f9f9f9; padding: 10px; border: 1px solid #ccc; white-space: pre-wrap; word-wrap: break-word; }
        h1, h2 { color: #444; }
    </style>
</head>
<body>
<h1>System Report</h1>
<p>Generated on: $(Get-Date)</p>
"@ | Set-Content -Path $ReportFilePath

# Section 1: System Information
$SystemInfo = @{
    "Operating System" = (Get-CimInstance Win32_OperatingSystem).Caption
    "System Manufacturer" = (Get-CimInstance Win32_ComputerSystem).Manufacturer
    "System Model" = (Get-CimInstance Win32_ComputerSystem).Model
    "Processor" = (Get-CimInstance Win32_Processor).Name
    "Total Physical Memory (GB)" = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
    "Current User" = $env:USERNAME
    "Last Boot Time" = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
}
$SystemInfoContent = $SystemInfo.GetEnumerator() | ForEach-Object { "$($_.Key): $($_.Value)" } | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "System Information" -Content $SystemInfoContent)

# Section 2: File System Details
$FileSystemDetails = Get-CimInstance Win32_LogicalDisk | ForEach-Object {
    "Drive $($_.DeviceID): Total: $([math]::Round($_.Size / 1GB, 2)) GB, Free: $([math]::Round($_.FreeSpace / 1GB, 2)) GB"
} | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "File System Details" -Content $FileSystemDetails)

# Section 3: Last 20 Files Edited
$RecentFiles = Get-ChildItem -Path $env:USERPROFILE -Recurse -ErrorAction SilentlyContinue |
    Sort-Object -Property LastWriteTime -Descending | Select-Object -First 20 |
    ForEach-Object {
        "File: $($_.FullName)`nLast Modified: $($_.LastWriteTime)"
    } | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "Last 20 Files Edited" -Content $RecentFiles)

# Section 4: Failed Login Attempts
$FailedLogins = Get-WinEvent -LogName Security -FilterXPath "*[System[(EventID=4625)]]" |
    Select-Object -Property @{Name="Time";Expression={$_.TimeCreated}}, @{Name="Address";Expression={$_.Properties[18].Value}} |
    ForEach-Object { "Time: $($_.Time), Address: $($_.Address)" } | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "Failed Login Attempts" -Content $FailedLogins)

# Section 5: System Logs Between Boots
$LastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$LogsSinceBoot = Get-WinEvent -FilterHashTable @{LogName='System'; StartTime=$LastBootTime} |
    ForEach-Object { "Time: $($_.TimeCreated), Message: $($_.Message)" } | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "System Logs Since Last Boot" -Content $LogsSinceBoot)

# Section 6: Data Transfer Statistics
$NetworkStats = Get-NetAdapterStatistics | ForEach-Object {
    "Adapter: $($_.Name)`nSent: $([math]::Round($_.OutboundBytes / 1MB, 2)) MB, Received: $([math]::Round($_.InboundBytes / 1MB, 2)) MB"
} | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "Network Data Transfers" -Content $NetworkStats)

# Section 7: System Users
$SystemUsers = Get-LocalUser | ForEach-Object {
    "Username: $($_.Name), Full Name: $($_.FullName), Enabled: $($_.Enabled), Created: $($_.Created)" 
} | Out-String
Add-Content -Path $ReportFilePath -Value (Write-HTMLSection -Title "System Users" -Content $SystemUsers)

# Close the HTML report
@"
</body>
</html>
"@ | Add-Content -Path $ReportFilePath -Encoding UTF8

Write-Host "System report saved to: $ReportFilePath" -ForegroundColor Green
