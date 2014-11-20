echo off
netsh firewall add portopening TCP 5666 Nagios enable CUSTOM 141.161.19.226/255.255.255.255,141.161.151.84/255.255.255.255 DOMAIN
exit