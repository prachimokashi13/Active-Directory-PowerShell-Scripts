param([string]$group_name, [string]$user_name)

$group_exist  = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
$user_exist  = ([bool](Get-ADUser -Filter 'Name -like $user_name'))

if($group_exist)
{
	if($user_exist)
	{
		Remove-ADGroupMember -Identity $group_name -Members $user_name -Confirm:$False
		write-host "User $user_name removed from group $group_name"
	}
	else
	{
		write-host "User $user_name doesn't exist"
	}
}
else
{
	write-host "Group $group_name doesn't exist"
}