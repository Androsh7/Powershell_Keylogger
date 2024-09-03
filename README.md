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

# Interpreting Output

Later functional version may do this automatically, but for now here is the output table

| Decimal | Name |
| - | - |
| 1 | Left Mouse Button |
| 2 | Right Mouse Button |
| 8 | Backspace |
| 9 | Tab |
| 20 | Caps Lock Key |
| 48 - 57 | 0 - 9 ([ASCII](https://www.asciitable.com/))|
| 65 - 90 | A - Z ([ASCII](https://www.asciitable.com/))|
| 160:16 | Left Shift |
| 161:16 | Right Shift |
| 219 | Delete |
