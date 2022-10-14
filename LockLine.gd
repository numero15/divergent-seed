#https://www.youtube.com/watch?v=-qpxjZjzLI0

extends Spatial

export (NodePath) var begin_node
export (NodePath) var end_node
export (float) var speed =.5
onready var path = get_node("Path")
onready var pathFollow =  get_node("Path/PathFollow")


func _process(delta):
	
	if !get_node_or_null(begin_node) or !get_node_or_null(end_node)  :
		queue_free()
		return

	path.curve = Curve3D.new()
	path.curve.add_point(get_node(begin_node).global_transform.origin, Vector3.ZERO,Vector3(0,10,0))
	path.curve.add_point(get_node(end_node).global_transform.origin)

#update bulet position
	pathFollow.set_unit_offset(pathFollow.get_unit_offset() + speed*delta)
	
