param([string]$user_name)

$user_exist = ([bool](Get-ADUser -Filter 'Name -like $user_name'))

if($user_exist -ne $True)
{
	write-host "User $User_name doesn't exist"
	
}

else
{
	Remove-ADUser -Identity $user_name -Confirm:$False
	write-host "User $user_name is deleted"
}
