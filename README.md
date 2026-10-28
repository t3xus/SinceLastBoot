# **SinceLastBoot**

![Static Badge](https://img.shields.io/badge/Author-Jgooch-1F4D37)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Target](https://img.shields.io/badge/Target-Microsoft%20Windows%2011-357EC7)

PowerShell toolset for headless Windows systems. On every SSH login it prints a concise system summary and writes a detailed HTML report of activity **since the last boot**.

---

## Features

- Terminal summary: CPU, memory, storage, GPU, updates, last boot, recent files, login counts
- HTML report saved to the Desktop (`System_Report_<timestamp>.html`)
- Events and file changes filtered to the current boot session
- Persistent `SinceLastBoot` alias (added to the user PowerShell profile)
- OpenSSH `ForceCommand` so the report runs automatically on SSH login

---

## Installation

1. Clone or download the repository.
2. Open PowerShell **as Administrator** (required to edit `sshd_config` and restart the service).
3. Run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\start.ps1
```

The installer:
- Backs up `C:\ProgramData\ssh\sshd_config`
- Adds a `ForceCommand` that runs the two report scripts
- Copies the scripts to `%USERPROFILE%`
- Restarts the OpenSSH service
- Registers the `SinceLastBoot` alias in your PowerShell profile
- Removes the installer files

---

## Usage

After installation, every new SSH session will show the terminal summary and generate an HTML report.

You can also run it manually at any time:

```powershell
SinceLastBoot
```

---

## Files

| File          | Purpose                                      |
|---------------|----------------------------------------------|
| `start.ps1`   | Installer (modifies sshd_config, copies scripts) |
| `ds1`         | Terminal report script (becomes `report.ps1`) |
| `ds2`         | HTML report script (becomes `reportexport.ps1`) |
| `cleanup.ps1` | Post-install cleanup and alias registration  |

---

## Notes

- Security log queries require administrative privileges for full detail.
- File scanning is limited to Documents, Desktop, and Downloads to keep reports fast.
- The HTML report is written to the Desktop of the user who logs in.

---

## License

MIT License. See the `LICENSE` file.
