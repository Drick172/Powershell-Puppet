@echo off

set _netsh_cmd=netsh advfirewall show currentprofile settings

FOR /f "tokens=1" %%G IN ('%_netsh_cmd%') DO If %%G == Domain (
@echo OK: Firewall running Domain profile
@exit 0
)

FOR /f "tokens=1" %%G IN ('%_netsh_cmd%') DO If %%G == Private (
@echo CRITICAL: Firewall running Private profile PLEASE CHECK CONNECTIONS
@exit 2
)

FOR /f "tokens=1" %%G IN ('%_netsh_cmd%') DO If %%G == Public (
@echo CRITICAL: Firewall running Public profile PLEASE CHECK CONNECTIONS
@exit 2
)