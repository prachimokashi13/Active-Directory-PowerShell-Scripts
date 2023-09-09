param([string]$domain_name, [string]$password, [string]$user_name)
$credential = New-Object System.Management.Automation.PSCredential($user_name,(ConvertTo-SecureString -String $password -asPlainText -Force))
Add-Computer -DomainName $domain_name -Credential $credential
write-host "Computer $user_name is added to domain $domain_name"
Restart-Computer
