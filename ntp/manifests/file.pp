#class ntp::file {
class ntp::file ($template = $ntp::params::template, $servers = $ntp::params::default_servers) inherits ntp {

  notify{ "The template variable is now ${template}": }
	#$template = $ntp::params::template
	#$servers = $ntp::params::default_servers

	file { '/etc/ntp.conf' :
		ensure	=> file,
		require	=> Package['ntp'],
#		content	=> template("ntp/${template}.erb"),
	}
}
