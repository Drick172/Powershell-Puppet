class ps_patch_install::prod_wed {

#Run Windows Updates on Wednesday
#--------------------------------------------------------------------
schedule { 'Maint_Window' :
   range => "5:00 - 13:00",
   weekday => 'Wednesday',
    }

exec { 'WindowsUpdates':
      command   => template('ps_patch_install/wed_prod_patch.ps1'),
      provider  => powershell,
      schedule => 'Maint_Window',
    }
#--------------------------------------------------------------------
}
