class nsclient {

# Install Nagios NSClient++
#--------------------------------------------------------------------
#Manually copy the nsclient installer
#--------------------------------
#file { "nsclient" :
#   path => "C:/downloads/NSClient++",
#   ensure => directory,
#   recurse => remote,
#   source => "puppet:///modules/nsclient/",
#   source_permissions => ignore,
#    }
#--------------------------------

exec { 'Run_NSC_Control.bat' :
    command => 'Start-Process "control.bat" -WorkingDirectory "C:\Downloads\NSClient++\64Bit\"-Verb runas -Wait',
    creates => "C:/Program Files/NSClient++/nsc.ini",
    provider => powershell,
}
#--------------------------------------------------------------------


}
