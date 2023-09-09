param([string]$domain_name, [string]$password, [string]$user_name)
$credential = New-Object System.Management.Automation.PSCredential($user_name,(ConvertTo-SecureString -String $password -asPlainText -Force))
Remove-Computer -UnjoinDomaincredential $credential -Force -PassThru -Verbose
write-host "Computer $user_name is removed from domain $domain_name"
Restart-Computer