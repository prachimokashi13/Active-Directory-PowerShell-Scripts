param([string]$domain_name, [string]$ip)

$password="ca`$hc0w"

$user_name= "administrator@" + $domain_name
$DNSServers2="10.112.0.1"
$DNSServers3="10.112.0.2"

Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IPENABLED=TRUE | Invoke-WmiMethod -Name SetDNSServerSearchOrder -ArgumentList (,$ip,$DNSServers2,$DNSServers3) 


$charcodes = 65..90

$allowedChars = $charcodes | ForEach-Object {[char][byte]$_}

$LengthOfName= 10
$hostName = "idfw" + (($allowedChars | Get-Random -Count $LengthOfName) -join "")



$credential = New-Object System.Management.Automation.PSCredential($user_name,(ConvertTo-SecureString -String $password -asPlainText -Force))
Add-Computer -DomainName $domain_name -Credential $credential -NewName  $hostName -Verbose
write-host "Computer $hostName is added to domain $domain_name"


Write-Host "Configure  domain Administrator auto logon"
$path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
#CheckPath $path
Set-ItemProperty -Path $path -Name AutoAdminLogon -Value 1
Set-ItemProperty -Path $path -Name DefaultUserName -Value $user_name
Set-ItemProperty -Path $path -Name DefaultPassword `
    -Value $password
Get-ItemProperty -Path $path |
    Select AutoAdminLogon, DefaultUserName, DefaultPassword


$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty -Path $RunOnceKey -Name setpolicy -Value "C:\set_cygwin.bat"


