param([string]$group_prefix,[int]$count)

$cnt=0
for($i=1; $i -le $count; $i++)
{
	$group_name= $group_prefix + [string]($i)
	$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
	if($group_exist)
	{
		Remove-ADGroup -Identity $group_name -Confirm:$False
		
	}
	
}

write-host "$count Groups are deleted"
	

