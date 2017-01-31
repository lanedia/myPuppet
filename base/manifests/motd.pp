class base::motd {
	$author = $base::params::author

	file { '/etc/motd':
		ensure	=> present,
		owner	=> 'root',
		group	=> 'root',
		content	=> template('base/motd.erb'),
		mode	=> '0644',

	}
}
