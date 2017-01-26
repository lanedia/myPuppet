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
)
{
    #$respFile = "${pkgName}.resp",

    $pkg_location = "${pkg_repo}/${pkg_type}/"
      notice('updating package $pkgName')
      notice('using repo = $pkg_repo')
      notice('Packate type = $pkg_type')

    if $pkg_type == 'Base' {
        #exec { "Package_RM_$pkgName" :
        #command     => "/bin/yes | /usr/sbin/pkgrm ${pkgName}",
        #onlyif => "/net/shlabsun1/archive/CCS/utils/check_installed.sh ${pkg_location} ${pkgName} ${pkg_type}",
        #} ->
        package { $pkgName :
            ensure  => installed,
            provider    => 'sun',
            source    => "${pkg_location}/${pkgName}",
            responsefile     => "${$pkg_location}/${pkgName}.resp",
            adminfile   => "${pkg_location}/install.admin",
        } 

    }
    elsif $pkg_type == 'Patch' {
        exec { "Patch_Add_$pkgName" : 
        command     => "/usr/sbin/pkgadd -d ${pkg_location}/${pkgName} -n -r ${pkg_location}/${pkgName}.resp -a ${pkg_location}/install.admin <${pkg_location}/automate.txt",
        onlyif => "/net/shlabsun1/archive/CCS/utils/check_installed.sh ${pkg_location} ${pkgName} ${pkg_type}",
        }
    }
    else {
      warning('Not updating package.')
    }
}

