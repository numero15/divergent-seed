extends PathFollow


func _process(delta):
	set_offset(get_offset()+ 2*delta)
