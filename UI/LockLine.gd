#https://www.youtube.com/watch?v=-qpxjZjzLI0

extends Spatial

export (NodePath) var begin_node
export (NodePath) var end_node
export (Array, int) var partition
onready var path = get_node("Path")
onready var trailPolygon = get_node("CSGPolygon")
var bulletNode = preload("res://UI/GeocyteBullet.tscn")
var dissolveAmout = 0.5


func _process(delta):
	
	if !get_node_or_null(begin_node) or !get_node_or_null(end_node)  :		
		queue_free()
		return
#	update position according to nodes position
	path.curve = Curve3D.new()
	path.curve.add_point(get_node(begin_node).global_transform.origin, Vector3.ZERO,Vector3(0,10,0))
	path.curve.add_point(get_node(end_node).global_transform.origin)

func _on_Timer_timeout():
	var newBullet = bulletNode.instance()
	newBullet.emitterNodePath = begin_node
	path.add_child(newBullet)

func bullet_intercepted(_targetPath):
	pass

func bullet_missed(_targetPath):
	dissolveAmout+=0.05
	if dissolveAmout >= 1.0 :
		queue_free()
	trailPolygon.material.set_shader_param("dissolve_amount", dissolveAmout)
	
