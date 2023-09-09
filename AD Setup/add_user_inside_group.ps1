
param([string]$group_name = "default", [string]$user_name, [string]$ou_name = "default", [string]$password = "Ca$hc0w@12345")

$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))
$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
$addomain = Get-ADDomain | select -ExpandProperty DistinguishedName
if($ou_exist -ne $True)
{
	NEW-ADOrganizationalUnit -Name $ou_name -Path "$addomain" -ProtectedFromAccidentalDeletion $false
}
if($group_exist -ne $True)
{
	NEW-ADGroup -Name $group_name -GroupScope Global -Path "OU= $ou_name, $addomain"
	if($user_exist -ne $True)
	{
		NEW-ADUser -Name $user_name -Path "CN = Users, $addomain"		
		Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
	}
	Add-ADGroupMember -Identity $group_name -Member $user_name
	write-host "User $user_name is added to group $group_name"
}
if($group_exist)
{
	if($user_exist -ne $True)
	{
		NEW-ADUser -Name $user_name -Path "CN = Users, $addomain"		
		Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
	}
	Add-ADGroupMember -Identity $group_name -Member $user_name
	write-host "User $user_name is added to group $group_name"
}

else
{
	$members = Get-ADGroupMember -Identity $group_name -Recursive | Select -ExpandProperty Name

	if ($members -contains $user_name)
	{
      		Write-Host "User $user_name exists in the group $group_name"
	}
	
}