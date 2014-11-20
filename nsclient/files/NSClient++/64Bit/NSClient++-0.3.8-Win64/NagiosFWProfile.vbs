Const nagDir = "C:\Program Files\NSClient++\"
Const nagSvc = " 'NSClient++' "
Const nagMOD = "use_ssl=1"
Const nagSTR1 = "[External Scripts]"
Const nagSTR2 = "check_FWProfile=scripts\"


Dim dateFormat
Dim nagOLD
Dim nagNEW
Dim fwVersion

nagOLD = nagDir & GetDate(dateFormat) & "_ORG_" & "nsc.ini"
nagNEW = nagDir & "nsc.ini"


call GetOS (fwVersion, NagDir)

call ModNSC (nagOLD, nagNEW, nagMOD, nagSTR1, nagSTR2, fwVersion)
call RestartNagiosService(nagSvc)


'*******************************************************************************
'*******************************************************************************
'****		Modify nsc.ini
'*******************************************************************************
Function ModNSC (nagOLD, nagNEW, nagMOD, nagSTR1, nagSTR2, fwVersion)
    Dim oFS, NagiosINFile, NagiosOUTFile, NagiosCurrentLine
    
    call RenameINI (nagNEW, nagOLD)
    
    
    Set oFS = CreateObject("Scripting.FileSystemObject") 
    Set NagiosOUTFile = ofs.OpenTextFile(nagNEW, 2, True)
    Set NagiosINFile = ofs.OpenTextFile(nagOLD, 1)
    Do Until NagiosINFile.AtEndOfStream
    	NagiosCurrentLine = NagiosInFile.ReadLine
        if LEFT(NagiosCurrentLine,9) = nagMOD then
	    NagiosOUTFile.writeLine(NagiosCurrentLine)
	    NagiosOUTFile.writeLine()
	    NagiosOUTFile.writeLine(nagSTR1)
	    NagiosOUTFile.writeLine(nagSTR2 & fwVersion)
        else
            NagiosOUTFile.writeLine(NagiosCurrentLine)
        End If
    Loop
    NagiosINFile.close
    NagiosOUTFile.close
    Set oFS=Nothing
End Function 
'*******************************************************************************
'*******************************************************************************
'*******************************************************************************
'****		Set current date
'*******************************************************************************
Function GetDate(yymmdd)
	GetDate = RIGHT(YEAR(date()),2) & PadDate(MONTH(date()),2) &_
	PadDate(DAY(date()),2) &_
         "-" & PadDate(HOUR(time()),2) & PadDate(MINUTE(time()),2)
End Function
'*******************************************************************************
'*******************************************************************************
'*******************************************************************************
'****		format two digit number 
'****		pad 1-9 with 0
'*******************************************************************************
Function PadDate(n, totalDigits) 
    if totalDigits > len(n) then 
        PadDate = String(totalDigits-len(n),"0") & n 
    else 
        PadDate = n 
    end if 
End Function 
'*******************************************************************************
'*******************************************************************************
'*******************************************************************************
'****		rename current nsc.ini
'*******************************************************************************
Function RenameINI (nagNEW, nagOLD)
    Dim oFS, nagORG, nagDel
    Set oFS = CreateObject("Scripting.FileSystemObject")
        Set nagORG = oFS.GetFile(nagNEW)
        nagORG.Move(nagOLD)
    Set oFS=Nothing
End Function 
'*******************************************************************************
'*******************************************************************************
'****		Stop Nagios Service
'****		Wait for service to stop
'****		Start Nagios Service
'****		Wait for service to start
'*******************************************************************************
Function RestartNagiosService(nagSvc)
Dim objWMIService, objItem, objService
Dim colListOfServices, strComputer
strComputer = "."


Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colListOfServices = objWMIService.ExecQuery _
("Select * from Win32_Service Where Name =" & nagSvc & " ")


For Each objService in colListOfServices
objService.StopService()
i=1
Do While i=<10
	   If objService.State = "Stopped" Then
	   i=1000 'exit loop
	   End If
	WSCript.Sleep 1000 'sleep for 1000 milliseconds
	i=i+1 'One second passed
	Loop

	objService.StartService()
	i=1
	Do While i<10 
	   If objService.State = "Running" Then
	   i=1000 'exit loop
	   End If
	WSCript.Sleep 1000 'sleep for 1000 milliseconds
	i=i+1 'One second passed
	Loop

	Next 
End Function 
'******************************************************************************
'*******************************************************************************
'*******************************************************************************
'*******************************************************************************
'****		Get OS Version
'*******************************************************************************
Function GetOS (fwVersion, nagDir)

Dim FSO

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colOperatingSystems = objWMIService.ExecQuery _
    ("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colOperatingSystems
	Select Case LEFT (objOperatingSystem.Version,3)
	Case "5.2"
		fwVersion="CheckFWDomainProfile.bat"
		Set FSO = CreateObject("Scripting.FileSystemObject")
		FSO.CopyFile fwVersion, NagDir & "scripts\"
	Case "6.0"
		fwVersion="CheckFWDomainProfileW2k8.bat"
		Set FSO = CreateObject("Scripting.FileSystemObject")
		FSO.CopyFile fwVersion, NagDir & "scripts\"
	Case "6.1"
		fwVersion="CheckFWDomainProfileW2k8.bat"
		Set FSO = CreateObject("Scripting.FileSystemObject")
		FSO.CopyFile fwVersion, NagDir & "scripts\"
	Case "5.0"
		fwVersion="CheckFWDomainProfileW2k.bat"
		Set FSO = CreateObject("Scripting.FileSystemObject")
		FSO.CopyFile fwVersion, NagDir & "scripts\"
	Case Else
		fwVersion="CheckFWDomainProfileW2k.bat"
		Set FSO = CreateObject("Scripting.FileSystemObject")
		FSO.CopyFile fwVersion, NagDir & "scripts\"
	End Select
Next

End Function