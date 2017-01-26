# == Class: ajas_shared_plan
#
# ajas_shared_plan: Shared Plan Product for Tecnotree
#
# === Parameters
#
class ajas_shared_plan (
) {

  $ajas_shared_plan_pkgs = [
	'AJAS-sharedPlanRestAPI',
	'AJAS-sharedPlanRenewals',
	'AJAS-reqRuntimeMods',
  ]

  package { $ajas_shared_plan_pkgs:
    ensure => latest
  }

}

