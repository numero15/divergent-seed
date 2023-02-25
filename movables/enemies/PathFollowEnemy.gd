extends PathFollow3D

var speed

func _ready():
#	speed = get_child(0).speed


func _process(delta):
	set_h_offset(get_h_offset()+ speed*delta)
