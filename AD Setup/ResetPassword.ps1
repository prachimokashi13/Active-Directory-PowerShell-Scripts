Import-Module ActiveDirectory 

$passwd= ConvertTo-SecureString -String "Admin!23" -AsPlainText –Force

for ($i=1 ;$i -le 100000 ; $i++){
$name= "ScaleUser"+ [string]($i)
Set-ADAccountPassword $name -NewPassword $passwd –Reset
Enable-ADAccount -Identity $name
}



