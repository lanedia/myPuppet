class base {
	$dnsutil = $osfamily ? {
		'RedHat'	=> 'bind-utils',
		'Debian'	=> 'dnsutils',
		default		=> 'bind-utils',
	}

	$systemupdate = $osfamily ? {
		'RedHat'	=> '/usr/bin/yum update -y',
		'Debian'	=> '/usr/bin/apt-get upgrade -y',
		default		=> '/usr/bin/yum update -y',
	}

	package { ['tree','bind-utils']:
                ensure		=> present,
        }

	schedule { 'systemdaily':
		period		=> daily,
		range		=> '00:00 - 01:00',
	}
	exec { $systemupdate:
		schedule	=> 'systemdaily',
	}
}
