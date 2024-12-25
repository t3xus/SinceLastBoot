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

## 📋 **Example Output**
### **Terminal Summary**:
```
Username: jdoe
Hostname: WIN-12345
CPU: Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz
Memory: 8 GB / 16 GB
Storage: 200 GB / 512 GB
GPU: NVIDIA GeForce RTX 2070

OS: Microsoft Windows 11 Pro
Windows Version: 22H2
Last Update: 2024-12-10
Last Security Update: 2024-12-01
Last User Logged In: jdoe

Recent Files Edited:
2024-12-23 14:45:00 - C:\Users\jdoe\Documents\report.docx
2024-12-23 14:30:00 - C:\Users\jdoe\Desktop\notes.txt
2024-12-22 18:20:00 - C:\Users\jdoe\Downloads\setup.exe
2024-12-22 10:05:00 - C:\Users\jdoe\Projects\code.ps1
2024-12-21 22:15:00 - C:\Users\jdoe\Pictures\image.png
```

### **HTML Report**:
The HTML report includes:
- A detailed breakdown of system metrics
- Recent file changes:
  - `report.docx` last edited on 2024-12-23
  - `notes.txt` last edited on 2024-12-23
  - `setup.exe` last edited on 2024-12-22
  - `code.ps1` last edited on 2024-12-22
  - `image.png` last edited on 2024-12-21
- Login and security logs
- Network activity

The report is saved to the Desktop as `System_Report_<timestamp>.html`.

---

## 📄 **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.
