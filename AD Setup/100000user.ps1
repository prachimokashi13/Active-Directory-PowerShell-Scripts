Import-Module ActiveDirectory 

for ($i=1 ;$i -le 100000 ; $i++){
$name= "ScaleUser"+ [string]($i)
$create = New-ADUser -Name $name -SamAccountName $name
}


for ($i=1 ;$i -le 50000 ; $i++){
$firstgroup = "ScaleGroup" + [string]$i
$secondgroup= "ScaleUser" + [string]($i)
 Add-ADGroupMember $firstgroup $secondgroup
}

for ($i=50001 ;$i -le 100000 ; $i++)
{

$secondgroup= "ScaleUser" + [string]($i)
 Add-ADGroupMember "ScaleGroup1" $secondgroup
 Add-ADGroupMember "ScaleGroup50000" $secondgroup
 
}
