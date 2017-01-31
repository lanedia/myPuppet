class base::variables {
	file { '/root/var_test.txt' :
		content	=> $topscope,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
	} 
	$localvar = "This is my local var"
	$topscope = "This is my local topscope"
	notify { "${::topscope} is your topscope variable" : }
	notify { "${::nodescope} is your nodescope variable" : }
	notify { "${localvar} is your localvar variable" : }
	notify { "${::operatingsystem} is your OS" : }
}
