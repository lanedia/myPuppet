class filedemo::rc {

	File <| group == "root" |> {
		group	=> "jeff",
	}
#	Package <| |> {
#		Require +> '[]',
#	}
}
