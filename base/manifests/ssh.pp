#class base::ssh inherits base::params {
class base::ssh {
	package { 'openssh-package':
		name		=> 'openssh-server',
                ensure		=> present,
        }
	
	file { '/etc/ssh/sshd_config' :
		ensure		=> file,
		owner		=> 'root',
		group		=> 'root',
		source		=> 'puppet:///modules/base/sshd_config',
		require		=> Package['openssh-package'],
		notify		=> Service['ssh-service-2'],
	}

	service { 'ssh-service':
		#name		=> $ssh_name,
		name		=> $base::params::ssh_name,
		ensure		=> running,
		alias		=> 'ssh-service-2',
		enable		=> true,
	}
}
