class ps_patch_install::prod_thur {

#Run Windows Updates on Thursday
#--------------------------------------------------------------------
schedule { 'Maint_Window' :
   range => "5:00 - 13:00",
   weekday => 'Thursday',
    }

exec { 'WindowsUpdates':
      command   => template('ps_patch_install/thur_prod_patch.ps1'),
      provider  => powershell,
      schedule => 'Maint_Window',
    }
#--------------------------------------------------------------------
}
