param([string]$group_name = "default", [string]$ou_name = "default", [string]$DC1 = "idfirewall1", [string]$DC2 = "com")

$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
if($group_exist)
{
	write-host "Group $group_name already exists"
}

else
{
	write-host "Group $group_name doesn't exist"
	if($ou_exist -ne $True)
	{
		write-host "Ou $ou_name doesn't exist"
		NEW-ADOrganizationalUnit -Name $ou_name -Path "DC = $DC1, DC = $DC2" -ProtectedFromAccidentalDeletion $false
		write-host "Ou $ou_name is created"
	}
	
	NEW-ADGroup -Name $group_name -GroupScope Global -Path "OU= $ou_name, DC = $DC1, DC = $DC2"  	
	write-host "Group $group_name is created and added to ou $ou_name"
	

}