extends PathFollow3D

@onready var rays = get_node("GeocyteBullet/Rays")
@onready var ball = get_node("GeocyteBullet/Mesh")
@onready var audioPlayer = get_node("AudioStreamPlayer3D")

var beatsToGoal = 2
var soundPath
var prev_unit_offset = 0.0
#export (float) var speed =.5
var emitterNodePath : NodePath
var isValidated = false
var tween

func _ready():
	tween= create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "progress_ratio",1.0,60/float(Settings.bpm)*beatsToGoal)
	tween.connect("finished",Callable(self,"tweenEnded"))

func tweenEnded():
	if !isValidated :
			get_tree().call_group("BulletListeners","bullet_missed", emitterNodePath)
	queue_free()


func _process(_delta):
	
#	set_progress_ratio(prev_unit_offset + speed*delta)
#	prev_unit_offset = get_progress_ratio()
		
	if get_progress_ratio()>0.9:
		ray_visible(true)
	if get_progress_ratio()<0.1 :
		ray_visible(false)
		
#	if get_progress_ratio() >= 1 :
#		if !isValidated :
#			get_tree().call_group("BulletListeners","bullet_missed", emitterNodePath)
#		queue_free()
		
	if Input.is_action_just_pressed("intercept") and get_progress_ratio()>0.95:
		isValidated = true
		get_tree().call_group("BulletListeners","bullet_intercepted", emitterNodePath)
		audioPlayer.stream = soundPath
		audioPlayer.play()

#listen to the metronome event
func on_beat():
	pass

func ray_visible(_v:bool):
	rays.visible = _v
	var ray_tween
	if _v :
#		tween =create_tween().set_trans(Tween.TRANS_QUAD)
#		tween.tween_property(ball,"scale",Vector3(2.5,2.5,2.5),.15)
		for _ray in rays.get_children():
			_ray.scale.z=.5
			ray_tween =create_tween().set_trans(Tween.TRANS_QUAD).bind_node(_ray)
			ray_tween.tween_property(_ray,"scale",Vector3(1,1,4),.1)
	else :	
		ball.scale = Vector3(1,1,1)
