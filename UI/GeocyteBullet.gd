extends PathFollow

onready var rays = get_node("GeocyteBullet/Rays")
onready var ball = get_node("GeocyteBullet/Mesh")
onready var audioPlayer = get_node("AudioStreamPlayer3D")

var soundPath
var prev_unit_offset = 0.0
export (float) var speed =.5
var emitterNodePath : NodePath
var isValidated = false
var tween

func _ready():
	tween= create_tween()
#	needs to be changed to follow the BPM
	tween.tween_property(self, "unit_offset",1.0,60/float(Settings.bpm)*2)
	tween.connect("finished", self, "tweenEnded")

func tweenEnded():
	if !isValidated :
			get_tree().call_group("BulletListeners","bullet_missed", emitterNodePath)
	queue_free()


func _process(delta):
	
#	set_unit_offset(prev_unit_offset + speed*delta)
#	prev_unit_offset = get_unit_offset()
		
	if get_unit_offset()>0.85:
		ray_visible(true)
	if get_unit_offset()<0.1 :
		ray_visible(false)
		
#	if get_unit_offset() >= 1 :
#		if !isValidated :
#			get_tree().call_group("BulletListeners","bullet_missed", emitterNodePath)
#		queue_free()
		
	if Input.is_action_just_pressed("intercept") and get_unit_offset()>0.85:
		isValidated = true
		get_tree().call_group("BulletListeners","bullet_intercepted", emitterNodePath)
		audioPlayer.stream = soundPath
		audioPlayer.play()

#listen to the metronome event
func on_beat():
	pass

func ray_visible(_v:bool):
	rays.visible = _v
	if _v :
		var tween :=create_tween().set_trans(Tween.TRANS_QUAD)
		tween.tween_property(ball,"scale",Vector3(2,2,2),.1)
		for _ray in rays.get_children():
			_ray.scale.z=.5
			tween =create_tween().set_trans(Tween.TRANS_QUAD)
			tween.tween_property(_ray,"scale",Vector3(1,1,3),.1)
	else :	
		ball.scale = Vector3(1,1,1)
