extends Spatial

onready var rays = get_node("Rays")
onready var ball = get_node("Mesh")

func ray_visible(_v:bool):
	rays.visible = _v
	if _v :
		var tween :=create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(ball,"scale",Vector3(2,2,2),.2)
		for _ray in rays.get_children():
			_ray.scale.z=.5
			tween =create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
			tween.tween_property(_ray,"scale",Vector3(1,1,3),.5)
	else :	
		ball.scale = Vector3(1,1,1)
