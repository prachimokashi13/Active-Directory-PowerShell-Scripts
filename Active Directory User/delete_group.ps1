param([string]$group_name)

$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))

if($group_exist -ne $True)
{
	write-host "Group $group_name doesn't exist"
	
}

else
{
	Remove-ADGroup -Identity $group_name -Confirm:$False
	write-host "Group $group_name is deleted"
}
