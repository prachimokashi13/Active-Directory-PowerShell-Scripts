
param([string]$user_prefix, [string]$group_name = "default", [int]$count, [string]$password = "Ca$hc0w@12345", [string]$ou_name = "default", [string]$DC1 = "idfirewall1", [string]$DC2 = "com")

$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
$cnt1=0
$cnt2=0
if([bool]$ou_exist -ne $True)
{
	write-host "Ou $ou_name doesn't exist"
	NEW-ADOrganizationalUnit -Name $ou_name -Path "DC = $DC1, DC = $DC2" -ProtectedFromAccidentalDeletion $False
	write-host "Ou $ou_name is created"

}
if($group_exist -ne $True)
{
	write-host "Group $group_name doesn't exist"
	NEW-ADGroup -Name $group_name -GroupScope Global -Path "OU= $ou_name, DC = $DC1, DC = $DC2"
	write-host "Group $group_name is created"
	
}
for ($i=1 ;$i -le $count ; $i++)
{
	$user_name= $user_prefix + [string]($i)
	$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))
	if($user_exist)
	{
		write-host "User $user_name already exists"
		$cnt1++
	}
	else
	{
		NEW-ADUser -Name $user_name -Path "CN = Users, DC = $DC1, DC = $DC2"
		Add-ADGroupMember -Identity $group_name -Member $user_name
		Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
		Enable-ADAccount -Identity $user_name -Confirm:$False
		write-host "User $user_name is created"
	}
}
write-host "$count Users with prefix $user_prefix are present in group $group_name in ou $ou_name"

else
{
	write-host "OU doesn't exist"
}
