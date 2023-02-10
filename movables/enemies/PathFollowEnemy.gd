extends PathFollow

var speed

func _ready():
	speed = get_child(0).speed


func _process(delta):
	set_offset(get_offset()+ speed*delta)
