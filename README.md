# **SinceLastBoot**

![Static Badge](https://img.shields.io/badge/Author-Jgooch-1F4D37)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Static Badge](https://img.shields.io/badge/Distribution-npm-orange)
![Target](https://img.shields.io/badge/Target-Microsoft%20Windows%2011%20Professional-357EC7)

![Windows Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToJdo1ENov4AmAmS1VxCUWba1ylMODgf3KMA&s)

**SinceLastBoot** is a PowerShell toolset designed for headless Windows installations. It generates detailed HTML reports on system and file changes for every SSH login and provides a summary directly in the terminal.

---

## 🚀 **Features**

### **System Reports**
- CPU, Memory, and Storage usage
- System updates and last boot time
- Network statistics and recently edited files
- Security logs, login attempts, and user information

### **HTML Reports**
- Saved for easy review and sharing.

### **Alias: SinceLastBoot**
- Runs `$env:USERPROFILE\report.ps1` and `$env:USERPROFILE\reportexport.ps1` in a single command.

---

## 💡 **Installation**
Run the `start.ps1` script:
```powershell
PS C:\> ./start.ps1
```
> Installation files are removed automatically after setup.

---

## 💻 **Usage**
Run the **SinceLastBoot** alias:
```powershell
PS C:\> SinceLastBoot
```

---

## 📄 **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.
