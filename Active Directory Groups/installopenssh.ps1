param([string]$domain_name)
$password="ca`$hc0w"

$user_name= $domain_name + "\administrator"


$credential = New-Object System.Management.Automation.PSCredential($user_name,(ConvertTo-SecureString -String $password -asPlainText -Force))

Write-Host "Configure  domain Administrator auto logon"
$path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
#CheckPath $path
Set-ItemProperty -Path $path -Name AutoAdminLogon -Value 1
Set-ItemProperty -Path $path -Name DefaultUserName -Value $user_name
Set-ItemProperty -Path $path -Name DefaultPassword `
    -Value $password
Get-ItemProperty -Path $path |
    Select AutoAdminLogon, DefaultUserName, DefaultPassword
#start-process "C:\Program Files\freeSSHd\unins000.exe" /SILENT

#Start-Sleep -s 60
#Set-Location -Path "C:\Program Files\OpenSSH\"

#Invoke-Expression