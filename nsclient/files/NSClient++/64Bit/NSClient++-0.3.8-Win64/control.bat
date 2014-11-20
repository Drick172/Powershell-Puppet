echo off
start /WAIT .\copyFiles.bat
start /WAIT .\firewall.bat
start /WAIT .\install.bat
start /wait .\NagiosFWProfile.bat
net start nsclient++
exit