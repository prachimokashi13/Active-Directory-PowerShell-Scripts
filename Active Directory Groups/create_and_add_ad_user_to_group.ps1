
param([string]$user_name, [string]$group_name = "default", [string]$ou_name = "default", [string]$password = "Ca$hc0w@12345", [string]$DC1 = "idfirewall1", [string]$DC2 = "com")

$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))
$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
if([bool]$user_exist)
{
	write-host "User $user_name already exists"
}
else
{
	if($group_exist -ne $True)
	{
		write-host "User $user_name doesn't exist"
		write-host "Group $group_name doesn't exist"
		if($ou_name)
		{
			if(!($ou_exist))
			{
			
				write-host "Ou $ou_name doesn't exist"
				NEW-ADOrganizationalUnit -Name $ou_name -Path "DC = $DC1, DC = $DC2" -ProtectedFromAccidentalDeletion $false
				write-host "Ou $ou_name is created"
				
			}
				
		NEW-ADGroup -Name $group_name -GroupScope Global -Path "OU= $ou_name, DC = $DC1, DC = $DC2"  	
		write-host "Group $group_name is created and added to ou $ou_name"
		NEW-ADUser -Name $user_name -Path "CN = Users, DC = $DC1, DC = $DC2"
		Add-ADGroupMember -Identity $group_name -Member $user_name
		Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
		Enable-ADAccount -Identity $user_name -Confirm:$False
		write-host "User $user_name is created and added to group $group_name"
			
		}
	}
	else
	{
		write-host "Group $group_name exists"
		NEW-ADUser -Name $user_name -Path "CN = Users, DC = $DC1, DC = $DC2"
		Add-ADGroupMember -Identity $group_name -Member $user_name
		Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
		Enable-ADAccount -Identity $user_name -Confirm:$False
		write-host "User $user_name is created and added to group $group_name in ou $ou_name"
		
	}
}
		