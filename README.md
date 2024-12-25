# **SinceLastBoot**

![Static Badge](https://img.shields.io/badge/Author-Jgooch-1F4D37)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Static Badge](https://img.shields.io/badge/Distribution-npm-orange)
![Target](https://img.shields.io/badge/Target-Microsoft%20Windows%2011%20Professional-357EC7)

![Windows Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToJdo1ENov4AmAmS1VxCUWba1ylMODgf3KMA&s)

**SinceLastBoot** is a PowerShell-based toolset designed to manage and report system information, configure SSH, and automate cleanup and reporting processes effectively. It combines multiple scripts and resources into a cohesive workflow.

---

## 🚀 **Capabilities**

### **`cleanup.ps1`**
- Deletes specified files (`ds1`, `ds2`, `start.ps1`) without requiring confirmation.
- Ensures efficient cleanup of unnecessary files to maintain system order.
- Registers the `SinceLastBoot` alias to run reports and performs self-deletion.

### **`report.ps1` and `reportexport.ps1`**
- Generates comprehensive system information reports, including details about:
  - CPU, Memory, and Storage usage.
  - System updates and last boot time.
  - Network statistics and recently edited files.
  - Security logs, login attempts, and user information.
- Reports are saved as HTML files for easy review and sharing.

### **`sshd_config.ps1`**
- Configures the `sshd_config` file for OpenSSH on Windows.
- Adds or updates the `ForceCommand` directive to run specific scripts (`report.ps1` and `reportexport.ps1`) upon SSH login.
- Ensures a backup of the original configuration is created for safety.
- Restarts the SSH service to apply changes.

### **`start.ps1`**
- Initializes tasks and serves as an entry point for other scripts in the workflow.
- Ensures critical setup steps are completed before proceeding with further automation.

### **Alias: `SinceLastBoot`**
- Combines the execution of two primary scripts located in:
  - `$env:USERPROFILE\report.ps1`
  - `$env:USERPROFILE\reportexport.ps1`
- Provides a single command alias to streamline the process of running both scripts.

---

## 💡 **Usage Example**

### To Execute the Cleanup Script
```powershell
PS C:\> .\cleanup.ps1
```

### To Run the SinceLastBoot Alias
```powershell
PS C:\> SinceLastBoot
```

### To Update `sshd_config`
```powershell
PS C:\> .\sshd_config.ps1
```

---

## 📄 **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.
