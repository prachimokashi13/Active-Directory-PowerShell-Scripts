param([string]$group_prefix = "group", [string]$user_prefix = "user", [string]$ou_name = "default", [string]$password = "Ca$hc0w@12345", [int]$group_count, [int]$user_count)
$gcount=1
for($ucount=1; $ucount -le $user_count; $ucount++)
{
	if($gcount -gt $group_count)
	{
		$gcount=1
	}
	$user_name = $user_prefix + [string]($ucount)
	$group_name = $group_prefix + [string]($gcount)
	write-host $user_name
	write-host $group_name
	$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
	$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))
	$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
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
		$group = Get-ADGroup -Filter 'Name -eq $group_name'
		$user = Get-ADUser -Filter 'Name -eq $user_name'
		Add-ADGroupMember -Identity $group -Members $user
	}
	else
	{
		if($user_exist -ne $True)
		{
			NEW-ADUser -Name $user_name -Path "CN = Users, $addomain"		
			Set-ADAccountPassword -Identity $user_name -Reset -NewPassword(ConvertTo-SecureString -AsPlainText $password -Force)
		}

		$members = Get-ADGroupMember -Identity $group_name -Recursive | Select -ExpandProperty Name
		if ($members -contains $user_name)
		{
      			Write-Host "User $user_name exists in the group $group_name"
		}
		else
		{
			$group = Get-ADGroup -Filter 'Name -eq $group_name'
			$user = Get-ADUser -Filter 'Name -eq $user_name'
			Add-ADGroupMember -Identity $group -Members $user
			write-host "User $user_name is added to group $group_name"
		}
	}
	$gcount++
}
write-host "Users added to groups"
