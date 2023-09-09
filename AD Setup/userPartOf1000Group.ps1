Import-Module ActiveDirectory 

$passwd= ConvertTo-SecureString -String "Admin!23" -AsPlainText –Force

$name= "User1000Group"
$create = New-ADUser -Name $name -SamAccountName $name
Set-ADAccountPassword $name -NewPassword $passwd –Reset
Enable-ADAccount -Identity $name


for ($i=1 ;$i -le 1000 ; $i++){
$name= "NotNestedGroup"+ [string]($i)
$create = New-ADGroup -Name $name -groupscope Global
Add-ADGroupMember $name "User1000Group"
}