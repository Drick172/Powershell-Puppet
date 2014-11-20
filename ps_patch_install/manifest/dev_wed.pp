class ps_patch_install::dev_wed {

#Run Windows Updates on Wednesday
#--------------------------------------------------------------------
schedule { 'Maint_Window_Wed' :
   range => "5:00 - 7:00",
   weekday => 'Wednesday',
    }

exec { 'WindowsUpdates':
      command   => template('ps_patch_install/wed_dev_patch.ps1'),
      provider  => powershell,
      schedule => 'Maint_Window_Wed',
    }
#--------------------------------------------------------------------
}
