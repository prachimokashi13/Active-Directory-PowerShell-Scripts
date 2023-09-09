param([string]$destination_group, [string]$source_group)

$destination_exist = ([bool](Get-ADGroup -Filter 'Name -like $destination_group'))

$source_exist = ([bool](Get-ADGroup -Filter 'Name -like $source_group'))

if($destination_exist)
{
	if($source_exist)
	{
		Remove-ADGroupMember -Identity $destination_group -Members $source_group -Confirm:$False
		write-host "Group $source_group removed from group $destination_group"
	}
	else
	{
		write-host "Group $destination_group doesn't exist"
	}
}
else
{
	write-host "Group $source_group doesn't exist"
}