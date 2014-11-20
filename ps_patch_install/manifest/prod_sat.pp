class ps_patch_install::prod_sat {

#Run Windows Updates on Saturday
#--------------------------------------------------------------------
schedule { 'Maint_Window' :
   range => "5:00 - 7:00",
   weekday => 'Saturday',
    }

exec { 'WindowsUpdates':
      command   => template('ps_patch_install/sat_prod_patch.ps1'),
      provider  => powershell,
      schedule => 'Maint_Window',
    }
#--------------------------------------------------------------------
}
