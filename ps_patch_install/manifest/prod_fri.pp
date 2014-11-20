class ps_patch_install::prod_fri {

#Run Windows Updates on Friday
#--------------------------------------------------------------------
schedule { 'Maint_Window' :
   range => "5:00 - 13:00",
   weekday => 'Friday',
    }

exec { 'WindowsUpdates':
      command   => template('ps_patch_install/fri_prod_patch.ps1'),
      provider  => powershell,
      schedule => 'Maint_Window',
    }
#--------------------------------------------------------------------
}
