echo off
netsh firewall add portopening TCP 5666 Nagios enable CUSTOM 172.31.26.231 DOMAIN
exit
