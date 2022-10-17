#https://www.youtube.com/watch?v=-qpxjZjzLI0

extends Spatial

export (NodePath) var begin_node
export (NodePath) var end_node
export (Array, int) var partition
onready var path = get_node("Path")

var bulletNode = preload("res://UI/GeocyteBullet.tscn")

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
	path.add_child(newBullet)
