extends Spatial

func _process(delta):
	var input_h = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_v = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	
#	transform.origin.x += input_h*delta*5
#	transform.origin.y += input_v*delta*5

#	translate(Vector3(input_h,input_v,0)*delta*5)
	
#	transform.basis = transform.basis.rotated(transform.basis.x,input_h*delta*5.0 )
	
#	rotate(Vector3.RIGHT, input_v*delta*5)
