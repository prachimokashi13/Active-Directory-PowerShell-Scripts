Import-Module ActiveDirectory 

for ($i=1 ;$i -le 5 ; $i++){
$name= "ScaleGroup"+ [string]($i)
$create = New-ADGroup -Name $name -groupscope Global
}



