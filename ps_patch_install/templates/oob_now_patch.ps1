#-------------------------------------------------------------------------------------------
#Update particular KB Articles

#$KBList = "-"
#Get-WUInstall -KBArticleID $KBList -AcceptAll -AutoReboot
#-------------------------------------------------------------------------------------------
#Or Update All applicable

Get-WUInstall -Category 'Security', 'Critical', 'Rollup', 'Important' -AcceptAll -AutoReboot


