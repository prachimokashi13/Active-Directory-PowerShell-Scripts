param([string]$group_name)

$group_exist  = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))

if($group_exist)
{
	(Get-ADGroup -Filter 'Name -like $group_name')
	
}
else
{
	write-host "Group $group_name doesn't exist"
}