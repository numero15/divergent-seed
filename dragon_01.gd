extends KinematicBody


#source http://kidscancode.org/godot_recipes/3d/simple_airplane/


# Can't fly below this speed
var min_flight_speed = 0
# Maximum airspeed
var max_flight_speed = 30
# Turn rate
export var turn_speed = 0.75
# Climb/dive rate
export var pitch_speed = 0.5
# Wings "autolevel" speed
var level_speed = 3.0
# Throttle change speed
var throttle_delta = 3.0
# Acceleration/deceleration
var acceleration = 6.0

# Current speed
var forward_speed = 0
# Throttle input speed
export var target_speed = 0
# Lets us disable certain things when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0


onready var mesh = $Armature/Skeleton
onready var particles = $Particles
onready var rayCast = $RayCastGround


func _process(delta):
	

#	trail.updatePos(mesh.global_transform*mesh.get_bone_global_pose(mesh.find_bone("Digit.003.L.004")))
	if rayCast.is_colliding():
		particles.transform.origin.y = - rayCast.global_transform.origin.distance_to(rayCast.get_collision_point())
		particles.emitting = true
	else :
		particles.emitting = false
		
func _physics_process(delta):
	get_input(delta)
	# Rotate the transform based on the input values
	# clamp rotation
	var new_rotation_x =  pitch_input * pitch_speed * delta
#	if  rotation.x + new_rotation_x > -.7 and   rotation.x + new_rotation_x< .7:
#		transform.basis = transform.basis.rotated(transform.basis.x, new_rotation_x)

#	THIS IS WRONG, but it works
	rotation.x = lerp(rotation.x,pitch_input*0.7,2*delta)

	#slowly return to horizontal
#	if pitch_input == 0 :		
#		var current_rot = Quat(transform.basis)
#		var target_rot = Quat(Vector3(0,0,1), 0)
#		var smoothrot = current_rot.slerp(target_rot, 0.01)
#		transform.basis = Basis(smoothrot)

	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	# If on the ground, don't roll the body
	if grounded:
		mesh.rotation.z = 0
	else:
		# Roll the body based on the turn input
		mesh.rotation.z = lerp(mesh.rotation.z, turn_input, level_speed * delta)

	# Accelerate/decelerate
	forward_speed = lerp(forward_speed, target_speed, acceleration * delta)
	# Movement is always forward
	velocity = -transform.basis.z * forward_speed
	# Handle landing/taking off
	if is_on_floor():
		if not grounded:
			rotation.x = 0
		velocity.y -= 1
		grounded = true
	else:
		grounded = false

	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	# Throttle input
#	if Input.is_action_pressed("throttle_up"):
#		target_speed = min(forward_speed + throttle_delta * delta, max_flight_speed)
#	if Input.is_action_pressed("throttle_down"):
#		var limit = 0 if grounded else min_flight_speed
#		target_speed = max(forward_speed - throttle_delta * delta, limit)
	# Turn (roll/yaw) input
	turn_input = 0
	if forward_speed > 0.5:
		turn_input -= Input.get_action_strength("roll_right")
		turn_input += Input.get_action_strength("roll_left")
	# Pitch (climb/dive) input
	pitch_input = 0
	if not grounded:
		pitch_input -= Input.get_action_strength("pitch_down")
	if forward_speed >= min_flight_speed:
		pitch_input += Input.get_action_strength("pitch_up")
		
