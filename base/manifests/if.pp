class base::if {
	if $::hostname =~ /^lanedia(\d*)/ {
		notice("You have arrived at server $0")
	}
}
