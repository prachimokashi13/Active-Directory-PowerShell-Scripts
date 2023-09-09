powershell -command "& C:\grant.ps1"

"%MCF%\bin\bash" --login -c "cygrunsrv --stop sshd"
"%MCF%\bin\bash" --login -c "cygrunsrv --remove sshd"
set "SSH_USER=cyg_server"
set "SSH_PW=ca$hc0w"
set "SSH_PORT=22"

"%MCF%\bin\bash" --login -c "mkpasswd -l -d -p \"$(cygpath -H)\" > /etc/passwd"
"%MCF%\bin\bash" --login -c "mkgroup -l -d > /etc/group"

"%MCF%\bin\bash" --login -c "/bin/ssh-host-config -y -c ntsec -p %SSH_PORT% -u %SSH_USER% -w %SSH_PW%" 

"%MCF%\bin\bash" --login -c "echo \"StrictModes no\" >> /etc/sshd_config"

"%MCF%\bin\bash" --login -c "cygrunsrv --start sshd"
