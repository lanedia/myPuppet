# == Module: pkgadd
#
# Generates pkgadd repository stanzas
#
# === Parameters:
#
class ppin_pkg_update (

   $ppin_pkgupdate = {},
   $pkg_repo = {},
)
{

    case $::osfamily {
        'Solaris': {}
        default: {
            fail('ppin_pkg_update module supports only Solaris based systems')
        }
    }

    create_resources("ppin_pkg_update::update", $ppin_pkgupdate )

}

