#https://www.youtube.com/watch?v=iu4ojdSRdnA

extends SpringArm
export (float) var near_length = 10.0
export (float) var far_length = 30.0
#export(float, 0.1, 0.5, 0.01) var camera_drag_margin = 0
#export(float, .0, 5.0, 0.1) var camera_rotation_speed_x= 2.5
#export(float, 0.0, 5.0, 0.1) var camera_rotation_speed_y= 2
#
#var center_screen
#var margin_size
#var cursor_pos
#var rotation_vector

#func _ready():
#	center_screen = get_viewport().size/2
#	margin_size = Vector2(camera_drag_margin*get_viewport().size.x, camera_drag_margin*get_viewport().size.y)

#func _physics_process(delta):	
#	cursor_pos = get_viewport().get_mouse_position()
#	if cursor_pos.x < margin_size.x or cursor_pos.x > get_viewport().size.x - margin_size.x : 
#			rotation_vector = (center_screen - cursor_pos).normalized()
#			rotate_y(rotation_vector.x*camera_rotation_speed_y*delta)
#			rotate_x(rotation_vector.y*camera_rotation_speed_x*delta)

#mouse control
var mouse_sensitivity = 0.15
var stick_sensitivity = 1.0
#var camera_anglev=0
var input_strength
onready var pivot = get_parent()

func _ready():
	spring_length = far_length
	add_excluded_object(RID(pivot.get_parent()))

func _input(event):     
	if event is InputEventMouseMotion and Settings.input_mode == Settings.InputMode.Keyboard:
		pivot.rotation_degrees.y -= event.relative.x*mouse_sensitivity
		rotation_degrees.x -= event.relative.y*(mouse_sensitivity)
		rotation_degrees.x = clamp(rotation_degrees.x,-30,10)
#		do not use this part
#		var changev=-event.relative.y*mouse_sens
#		if camera_anglev+changev>-50 and camera_anglev+changev<50:
#			camera_anglev+=changev
#			rotate_x(deg2rad(changev))
	else :
		pass

#stick control

func _physics_process(delta):
	if Settings.input_mode == Settings.InputMode.Pad :
		input_strength =  Input.get_action_strength("pan_left")- Input.get_action_strength("pan_right")
		pivot.rotate_y(input_strength * stick_sensitivity * delta)
		
		input_strength =  Input.get_action_strength("crosshair_up")- Input.get_action_strength("crosshair_down")
		rotate_x(input_strength * stick_sensitivity * delta)
		rotation_degrees.x = clamp(rotation_degrees.x,-30,10)
		
	else :
		pass

func animate_length(zoom_in:bool):
	var tween :=create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	if zoom_in:
		tween.tween_property(self,"spring_length",near_length,1)
	else :
		tween.tween_property(self,"spring_length",far_length,1)
	pass

