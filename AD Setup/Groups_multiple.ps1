Import-Module ActiveDirectory

do{

$val=read-host "Enter number of groups :"
if(![bool]($val -as [int]))
{
write-host" only integers"
}

}
until([bool]($val -as [int]))

for($i=1;$i -le $val;$i++)
{
$name="Grp"+[string]($i)
$create = New-ADGroup -Name $name -groupscope Global


}