class base::params {

	case $osfamily {
		'RedHat'	: { $ssh_name= 'sshd' }
		'Debian'	: { $ssh_name= 'ssh' }
		default		: { fail('os not suported by puppet module ssh') }
	}
	$author = "Root"
	#$ssh_name = $osfamily ? {
	#	'RedHat'	=> 'sshd',
	#	'Debian'	=> 'ssh',
	#	default		=> 'value',
	#}
}
