param([string]$user_name)

$user_exist  = ([bool](Get-ADUser -Filter 'Name -like $user_name'))

if($user_exist)
{
	(Get-ADUser -Filter 'Name -like $user_name')
	
}
else
{
	write-host "User $user_name doesn't exist"
}