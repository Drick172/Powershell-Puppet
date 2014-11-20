@echo off

set _netsh_cmd=netsh firewall show currentprofile

FOR /f "tokens=1" %%G IN ('%_netsh_cmd%') DO If %%G == Domain (
@echo OK: Firewall running Domain profile
@exit 0
)

FOR /f "tokens=1" %%G IN ('%_netsh_cmd%') DO If %%G == Standard (
@echo CRITICAL: Firewall running Standard profile PLEASE CHECK CONNECTIONS
@exit 2
)