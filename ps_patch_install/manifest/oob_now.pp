
class ps_patch_install::oob_now {

#Run Windows Updates on Wednesday
#--------------------------------------------------------------------
exec { 'WindowsUpdates':
      command   => template('ps_patch_install/oob_now_patch.ps1'),
      provider  => powershell,
    }
#--------------------------------------------------------------------
}

