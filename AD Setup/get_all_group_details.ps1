Import-Module ActiveDirectory

$a=(Get-ADGroup -Filter 'Name -like "*"').count
write-host "$a"

Get-ADGroup -Filter 'Name -like "*"'