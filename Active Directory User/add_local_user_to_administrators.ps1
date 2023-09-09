
param([string]$user_name)
Add-LocalGroupMember -Group "Administrators" -Member $user_name