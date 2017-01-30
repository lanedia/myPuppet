class localusers {
	user { 'admin':
		ensure		=> present,
		shell		=> '/bin/bash',
		home		=> '/home/admin',
		gid		=> 'wheel',
		managehome	=> true,
		password	=> '$6$rjcEd8o6$fmMN1Vl6jqKXyBuO6ITfvobTZhKfAHqzi7L33KC47E2esXIctDeblz7GHDssRa43pF1qX6oLGvc77BwqOxcwC/',
	}

	user { 'jeff':
		ensure		=> present,
		shell		=> '/bin/bash',
		home		=> '/home/jeff',
		groups		=> ['wheel','finance'],
		managehome	=> true,
	}
}
