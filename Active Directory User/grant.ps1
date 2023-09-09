 Import-Module "C:\UserRights.psm1"
 Grant-UserRight -Account "cyg_server@idfirewall1.com" -Right SeServiceLogonRight
 Grant-UserRight -Account "cyg_server@idfirewall1.com" -Right SeCreateTokenPrivilege
 Grant-UserRight -Account "cyg_server@idfirewall1.com" -Right SeAssignPrimaryTokenPrivilege
 Grant-UserRight -Account "cyg_server@idfirewall1.com" -Right SeIncreaseQuotaPrivilege

 #C:\set_cygwin.bat
