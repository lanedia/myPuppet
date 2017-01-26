# == Module: pkgadd
#
# Generates pkgadd repository stanzas
#
# === Parameters:
#
#
#
define ppin_pkg_update::update (
    $pkgName = $title,
    $pkg_type = 'Base',
    $pkg_repo = "/net/shlabsun1/archive/CCS/NightlyBuild/PPIN/",
    $install_files = "/net/shlabsun1/archive/CCS/NightlyBuild/PPIN/",
)
{

#  # create a fully qualified full host entry with an alias
#  host { 'ntpserver.example.com':
#    ip           => '194.42.56.196',
#    host_aliases => 'timeserver',
#  }

    $pkg_location = "${pkg_repo}/${pkg_type}/"
    $pkgAdmFile = "${install_files}/install.admin"
    $automateFile = "${install_files}/automate.txt"
    $alreadyInstalled = "true"
      notice('updating package $pkgName')
      notice('using repo = $pkg_repo')
      notice('Packate type = $pkg_type')

    if $pkg_type == 'Base' {
	# Only execute if the package is already installed (hence the use of the ${alreadyInstalled} variable)
        exec { "Package_RM_$pkgName" :
        command     => "/bin/yes | /usr/sbin/pkgrm ${pkgName}",
        onlyif => "/net/shlabsun1/archive/CCS/utils/ppin_check_installed.sh ${pkg_location} ${pkgName} ${pkg_type} ${alreadyInstalled}",
        } ->
        exec { "PkgReplace_$pkgName" :
            command     => "/usr/sbin/pkgadd -d ${pkg_location}/${pkgName} -n -r ${install_files}/${pkgName}.resp -a ${pkgAdmFile} <${automateFile}",
        }
	# Only execute if the package is not already installed (hence we do not use the ${alreadyInstalled} variable)
        exec { "PkgAdd_$pkgName" :
            command     => "/usr/sbin/pkgadd -d ${pkg_location}/${pkgName} -n -r ${install_files}/${pkgName}.resp -a ${pkgAdmFile} <${automateFile}",
        	onlyif => "/net/shlabsun1/archive/CCS/utils/ppin_check_installed.sh ${pkg_location} ${pkgName} ${pkg_type}",
        }
	# IF TCCSDpp package, the upgrade script is provided, use it :)
        if $pkgName == 'TCCSDpp' {
            exec { "Upgrade_db_$pkgName" :
                command     => '/bin/su - tecnomen -c "/bin/yes | /opt/TCCSDbase/03.00/db/pp/upgrades/upgrade_CGW_11.00.a_OCS_03.00.a.scr"',
            }
        }
	# Only execute upgrade.scr if one of the following packages
        elsif ( $pkgName == 'TINSppvoice' ) or ( $pkgName == 'TINScgwDB' ) {
            exec { "Upgrade_$pkgName" :
                command     => '/bin/su - tecnomen -c "/net/shlabsun1/archive/CCS/utils/upgrade.scr $pkgName"',
            }
        }

    }
    elsif $pkg_type == 'Patch' {
      notice('CHeck if package is installed, if it is, remove it and then re-install the latests for $pkgName')
	# Only execute if the package is already installed (hence the use of the ${alreadyInstalled} variable)
        exec { "Patch_Add_$pkgName" :
            command     => "/usr/sbin/pkgadd -d ${pkg_location}/${pkgName} -n -r ${install_files}/${pkgName}.resp -a ${pkgAdmFile} <${automateFile}",
            onlyif => "/net/shlabsun1/archive/CCS/utils/ppin_check_installed.sh ${pkg_location} ${pkgName} ${pkg_type} ${alreadyInstalled}",
        }
      notice('Now to run upgrade scripts for $pkgName')
	# Only execute upgrade.scr if one of the following packages
        if ( $pkgName == 'TINSppvoice' ) or ( $pkgName == 'TINScgwDB' ) {
            exec { "Upgrade_$pkgName" :
                command     => '/bin/su - tecnomen -c "/net/shlabsun1/archive/CCS/utils/upgrade.scr $pkgName"',
            }
        }
    }
    else {
      warning('Not updating package.')
    }
}
