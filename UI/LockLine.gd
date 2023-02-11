#https://www.youtube.com/watch?v=-qpxjZjzLI0

extends Spatial

export (NodePath) var begin_node
export (NodePath) var end_node
export (Array, int) var partition
onready var path = get_node("Path")
onready var trailPolygon = get_node("CSGPolygon")
var bulletNode = preload("res://UI/GeocyteBullet.tscn")
var dissolveAmout = 0.5
#used to know when to add a bullet
var beat_count = 0
var totalNotes = 0
var currentNoteIndex = -1
var currentStavePath
#func _ready():
#	print (get_node(begin_node).get_node("Partition"))

func _process(delta):
	
	if !get_node_or_null(begin_node) or !get_node_or_null(end_node)  :		
		queue_free()
		return
#	update position according to nodes position
	path.curve = Curve3D.new()
	path.curve.add_point(get_node(begin_node).global_transform.origin, Vector3.ZERO,Vector3(0,10,0))
	path.curve.add_point(get_node(end_node).global_transform.origin)

#listen to the metronome event
func on_beat():
	if get_node_or_null(begin_node)==null or get_node_or_null(end_node)==null :
		return
	
#	start a new stave if none is active
	if currentNoteIndex == -1:
		startNewStave()
		return
		
#if the current note is not finished then pass
	if beat_count != get_node(currentStavePath).get_child(currentNoteIndex).duration*4 :
		pass
	elif currentNoteIndex == totalNotes-1 :
		startNewStave()
	else :
		add_bullet();

	beat_count +=1
	
func startNewStave():
	currentStavePath = get_node(begin_node).startStave()
	currentNoteIndex = -1
	totalNotes =  get_node(currentStavePath).get_child_count()
	
	add_bullet();
	
func add_bullet():
	currentNoteIndex+=1
	var newBullet = bulletNode.instance()
	newBullet.emitterNodePath = begin_node
	newBullet.soundPath = get_node(currentStavePath).get_child(currentNoteIndex).sound
	newBullet.beatsToGoal = get_node(begin_node).lockLineDuration
	path.add_child(newBullet)
	beat_count = 0
	

func bullet_intercepted(_targetPath):
	pass

func bullet_missed(_targetPath):
	dissolveAmout+=0.05
	if dissolveAmout >= 1.0 :
		queue_free()
	trailPolygon.material.set_shader_param("dissolve_amount", dissolveAmout)
	
