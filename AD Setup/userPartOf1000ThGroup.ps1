Import-Module ActiveDirectory 

$passwd= ConvertTo-SecureString -String "Admin!23" -AsPlainText –Force

$name= "NGCAD2User1"
$create = New-ADUser -Name $name -SamAccountName $name
Set-ADAccountPassword $name -NewPassword $passwd –Reset
Enable-ADAccount -Identity $name


for ($i=1 ;$i -le 1000 ; $i++){
$name= "NGCAD2Group"+ [string]($i)
$create = New-ADGroup -Name $name -groupscope Global -Server kcdomain1.ssodc.local
}

for ($i=1 ;$i -le 999 ; $i++){
$firstgroup = "NGCAD2Group" + [string]$i
$secondgroup= "NGCAD2Group" + [string]($i+1)
 Add-ADGroupMember $firstgroup $secondgroup -Server kcdomain1.ssodc.local
}

Add-ADGroupMember "NGCAD2Group1" "NGCAD2User1" -Server kcdomain1.ssodc.local