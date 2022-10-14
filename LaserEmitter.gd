extends Spatial

export (PackedScene) var Laser
export(NodePath) onready var parent = get_node(parent)

func spawn(targets:Array):
	var laser_instance
	var target
	
	for id in targets:
		laser_instance= Laser.instance()
		target = instance_from_id(id)
		get_tree().get_root().get_node("Level").add_child(laser_instance)
		print('spawn')
		laser_instance.target_id = id
		laser_instance.transform.origin = parent.transform.origin
		laser_instance.direction =   (target.transform.origin -  laser_instance.transform.origin).normalized()

