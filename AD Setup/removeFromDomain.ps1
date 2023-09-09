
$password="ca`$hc0w"
$domain_name= (Get-WmiObject win32_computersystem).Domain
$user_name= "administrator@" + $domain_name
$hostName = (Get-WmiObject win32_computersystem).DNSHostName

$credential = New-Object System.Management.Automation.PSCredential($user_name,(ConvertTo-SecureString -String $password -asPlainText -Force))
Remove-Computer -UnjoinDomainCredential $credential -Force -PassThru -Verbose
write-host "Computer $hostName is Removed from domain $domain_name"


