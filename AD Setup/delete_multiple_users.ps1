param([string]$user_prefix,[int]$count)

for($i=1; $i -le $count; $i++)
{
	$user_name= $user_prefix + [string]($i)
	$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))
	if($user_exist)
	{
		Remove-ADUser -Identity $user_name -Confirm:$False			
	}
	
}

write-host "$count Users are deleted"
	

