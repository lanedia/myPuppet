class ntp ($package = $ntp::params::package_name) inherits ntp::params {
#class ntp ($package ) inherits ntp::params {
	package { 'ntp':
		name	=> $package,
		ensure	=> present,
	}

  #class { 'ntp::file' : template => 'hello', }
  class { 'ntp::file' : template => "$ntp::params::template", }
  
	#include ntp::file
	include ntp::service
}
