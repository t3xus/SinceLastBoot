# **SinceLastBoot**

![Static Badge](https://img.shields.io/badge/Author-Jgooch-1F4D37)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Static Badge](https://img.shields.io/badge/Distribution-npm-orange)
![Target](https://img.shields.io/badge/Target-Microsoft%20Windows%2011%20Professional-357EC7)

![Windows Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToJdo1ENov4AmAmS1VxCUWba1ylMODgf3KMA&s)

**SinceLastBoot** is a PowerShell-based toolset designed to report environment changes to headless windows installs.
Once installed every ssh login has an html report generated that details system and file changes since last login, current user also recieves a summary in terminal. 

- Generates comprehensive system information reports on:
  - CPU, Memory, and Storage usage.
  - System updates and last boot time.
  - Network statistics and recently edited files.
  - Security logs, login attempts, and user information.
  - Reports are saved as HTML files for easy review and sharing.

### **Alias: `SinceLastBoot`**
- Combines the execution of two primary scripts located in:
  - `$env:USERPROFILE\report.ps1`
  - `$env:USERPROFILE\reportexport.ps1`
- Provides a single command alias to streamline the process of running both scripts.

##  **Installation**

./start.ps1
All install data is removed from your system after installing, 


### To Run the SinceLastBoot Alias
```powershell
PS C:\> SinceLastBoot
```



---

## 📄 **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.
