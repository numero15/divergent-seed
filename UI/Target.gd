extends KinematicBody

func _physics_process(delta):
#	var rotation = -self.global_transform.origin +  get_viewport().get_camera().global_transform.origin
#	rotation = rotation.normalized()
#	transform.basis = transform.basis.rotated(rotation, PI)
	look_at(get_viewport().get_camera().global_transform.origin,Vector3(0,1,0))

