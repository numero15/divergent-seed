#source https://godotengine.org/qa/81210/3d-make-object-follow-mouse

extends Node3D
#@export(NodePath) onready var camera = get_node(camera)
@onready var camera = get_node("..")
@onready var mesh = $MeshInstance3D

@onready var texture_unlock = preload("res://UI/crosshair_unlock.png")
@onready var texture_lock = preload("res://UI/crosshair_lock.png")
@onready var dragon_mesh = get_node("../../../..")
var is_pressed = false
var locked_list = []
signal enemies_locked

func _ready():
#	center reticle
	var mouse_pos = get_viewport().get_visible_rect().size/2
	var camera_position = camera.project_ray_origin(mouse_pos)
	var ray_end = camera_position + camera.project_ray_normal(mouse_pos) * 10
	global_transform.origin= ray_end;

func _input(event):
	
	if event.is_action_pressed("lock"):
		is_pressed = true
		locked_list.clear()
		mesh.get_surface_override_material(0).albedo_texture = texture_unlock
		
	if event.is_action_released("lock"):
		is_pressed = false
		mesh.get_surface_override_material(0).albedo_texture = texture_lock
		if locked_list.size()>0:
			emit_signal("enemies_locked",locked_list)

	var from
	var to
	var space_state = get_world_3d().direct_space_state
	var intersection = null
	
	if Settings.input_mode == Settings.InputMode.Keyboard and event is InputEventMouseMotion:
		var mouse_pos = event.position
		
#		#raycasting enemies hitboxes if mouse is pressed
		if is_pressed :
			from = camera.project_ray_origin(mouse_pos)
			to = from + camera.project_ray_normal(mouse_pos) * 500
			var ray_query = PhysicsRayQueryParameters3D.new()
			ray_query.from = from
			ray_query.to = to
			ray_query.exclude = [dragon_mesh]
			ray_query.collide_with_areas = true
			intersection= space_state.intersect_ray(ray_query)

	if  Settings.input_mode == Settings.InputMode.Pad and  (event.is_action_pressed("crosshair_right") or event.is_action_pressed("crosshair_left")or event.is_action_pressed("crosshair_up") or event.is_action_pressed("crosshair_down")):
		#raycasting enemies hitboxes if mouse is pressed
		if is_pressed :
			from = camera.project_ray_origin(camera.unproject_position(global_transform.origin))
			to = from + camera.project_ray_normal(camera.unproject_position(global_transform.origin)) * 500
			var ray_query = PhysicsRayQueryParameters3D.new()
			ray_query.from = from
			ray_query.to = to
			ray_query.exclude = [dragon_mesh]
			ray_query.collide_with_areas = true
			intersection= space_state.intersect_ray(ray_query)
	
	if intersection and is_pressed:
		if intersection.collider.get_collision_mask()==2 :
			update_locked(intersection.collider_id)

func _physics_process(delta):
	#positionning the reticle
	
	
#	mouse input
	if Settings.input_mode == Settings.InputMode.Keyboard :
		var mouse_pos = get_viewport().get_mouse_position()
		var camera_position = camera.project_ray_origin(mouse_pos)
		var ray_end = camera_position + camera.project_ray_normal(mouse_pos) * 10
		global_transform.origin= ray_end;
#
#	stick input
	if Settings.input_mode == Settings.InputMode.Pad :
		var new_pos = Vector2.ZERO
		new_pos.x = (Input.get_action_strength("crosshair_right") - Input.get_action_strength("crosshair_left"))*delta*10
		new_pos.y = (Input.get_action_strength("crosshair_up") - Input.get_action_strength("crosshair_down"))*delta*10
		transform.origin.x+=new_pos.x
		transform.origin.y+=new_pos.y
		transform.origin.x = clamp(transform.origin.x,-12,12)
		transform.origin.y = clamp(transform.origin.y,-6,6)

#add an element to the locked list
func update_locked(id:int):
	if !locked_list.has(id):
		locked_list.append(id)



