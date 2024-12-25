# PowerShell System Since Last Boot Report 
clear
# Colors and Formatting
function Write-Colored {
    param (
        [string]$Text,
        [string]$Color = "White"
    )
    try {
        Write-Host $Text -ForegroundColor $Color -NoNewline
    } catch {
        Write-Host $Text -NoNewline  # Fallback to plain text
    }
}

function Write-ColoredLine {
    param (
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Colored $Text $Color
    Write-Host
}

# Helper function for formatted label and value output
function Write-LabeledLine {
    param (
        [string]$Label,   # The label text
        [string]$Value,   # The value text
        [string]$LabelColor = "DarkYellow",  # Default color for the label
        [string]$ValueColor = "White"       # Default color for the value
    )
    Write-Colored "${Label}: " $LabelColor  # Corrected to use ${} for variable interpolation
    Write-ColoredLine "$Value" $ValueColor
}

# Header Section
function Draw-Header {
    Write-Host
}

# Gather System Information
function Gather-SystemInfo {
    $Info = @{
        Username         = $env:USERNAME
        Hostname         = $env:COMPUTERNAME
        OS               = (Get-CimInstance Win32_OperatingSystem).Caption
        CPU              = (Get-CimInstance Win32_Processor).Name
        Memory           = @{
            Total = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
            Used  = [math]::Round($TotalMemory - ((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB), 2)
        }
        Storage          = @{
            Total = [math]::Round((Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object -Property Size -Sum).Sum / 1GB, 2)
            Used  = [math]::Round((Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Measure-Object -Property FreeSpace -Sum).Sum / 1GB, 2)
        }
        GPU              = (Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name) -join ", "
        WindowsVersion   = (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion').ReleaseId
        LastUpdate       = (Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn
        SecurityUpdate   = (Get-HotFix | Where-Object {$_.Description -like '*Security*'} | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn
        LastUserLoggedIn = (Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty UserName)
    }
    return $Info
}

# Display System Info
function Display-SystemInfo {
    param ($Info)
    Write-LabeledLine "Username" $Info.Username
    Write-LabeledLine "Hostname" $Info.Hostname
    Write-LabeledLine "CPU" $Info.CPU
    Write-LabeledLine "Memory" "$($Info.Memory.Used) GB / $($Info.Memory.Total) GB"
    Write-LabeledLine "Storage" "$($Info.Storage.Used) GB / $($Info.Storage.Total) GB"
    Write-LabeledLine "GPU" $Info.GPU
    Write-Host
    Write-LabeledLine "OS" $Info.OS
    Write-LabeledLine "Windows Version" $Info.WindowsVersion
    Write-LabeledLine "Last Update" $Info.LastUpdate
    Write-LabeledLine "Last Security Update" $Info.SecurityUpdate
    Write-LabeledLine "Last User Logged In" $Info.LastUserLoggedIn
    Write-Host
}

# Retrieve Last Edited Files
function Display-LastEditedFiles {
    Write-ColoredLine "Last 10 Files Edited:" "Yellow"
    $TargetDirectories = @("$env:USERPROFILE\Documents", "$env:USERPROFILE\Desktop")
    $Files = $TargetDirectories |
             ForEach-Object { Get-ChildItem -Path $_ -Recurse -ErrorAction SilentlyContinue } |
             Sort-Object -Property LastWriteTime -Descending | Select-Object -First 10
    if ($Files) {
        foreach ($File in $Files) {
            $FileDate = $File.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
            Write-ColoredLine "$FileDate - $($File.FullName)" "Gray"
        }
    } else {
        Write-ColoredLine "No recent files found." "Gray"
    }
    Write-Host
}

# Login Attempts Section
function Display-LoginAttempts {
    Write-ColoredLine "Login Attempts:" "Yellow"
    $LoginEvents = Get-WinEvent -LogName Security -FilterXPath "*[System[(EventID=4624 or EventID=4625)]]" -MaxEvents 50 |
                   Select-Object -Property @{Name="User";Expression={($_.Properties[5].Value)}}, TimeCreated, Id
    $TotalAttempts = $LoginEvents.Count
    Write-LabeledLine "Total Login Attempts" $TotalAttempts
    Write-Host
}

# Footer Section
function Draw-Footer {
    Write-Host

}

# Main Execution
try {
    Draw-Header
    $SystemInfo = Gather-SystemInfo
    Display-SystemInfo -Info $SystemInfo
    Display-LastEditedFiles
    Display-LoginAttempts
    Draw-Footer
} catch {
    Write-ColoredLine "An error occurred: $_" "Red"
}
