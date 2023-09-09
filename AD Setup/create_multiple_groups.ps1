
param([string]$group_prefix, [int]$count, [string]$ou_name = "default")

$ou_exist = ([bool](Get-ADOrganizationalUnit -Filter 'Name -like $ou_name'))
$cnt1=0
$cnt2=0
$addomain = Get-ADDomain | select -ExpandProperty DistinguishedName
if([bool]$ou_exist -ne $True)
{
	write-host "Ou $ou_name doesn't exist"
	NEW-ADOrganizationalUnit -Name $ou_name -Path "$addomain" -ProtectedFromAccidentalDeletion $False
	write-host "Ou $ou_name is created"

}

for ($i=1 ;$i -le $count ; $i++)
{
	$group_name= $group_prefix + [string]($i)
	$group_exist = ([bool](Get-ADGroup -Filter 'Name -like $group_name'))
	if($group_exist)
	{
		write-host "Group $group_name already exists"
		$cnt1++
	}
	else
	{
		$create = NEW-ADGroup -Name $group_name -GroupScope Global -Path "OU= $ou_name, $addomain"
		write-host "Group $group_name is created"
		$cnt2++
	}
}
write-host "$count Groups with prefix $group_prefix are present in ou $ou_name"

