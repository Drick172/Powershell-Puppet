echo off
start /WAIT .\copyFiles.bat
start /WAIT .\install.bat
start /WAIT .\Firewall.bat
net start nsclient++
exit