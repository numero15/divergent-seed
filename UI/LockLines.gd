extends Spatial

var LockLine = preload("res://UI/LockLine.tscn")
var prevChildCount = 0

signal setZoom

func _process(delta):
	if get_child_count() != 0 and prevChildCount==0:
		emit_signal("setZoom",false)
	if get_child_count() ==0 and prevChildCount!=0:
		emit_signal("setZoom",true)
		
	prevChildCount = get_child_count()
	
func add_lines(_ids:Array):
	
	var toRemove = null

	for id in _ids: 
		toRemove = null
		for line in get_children():
			if get_node(line.begin_node).get_instance_id() == id :
				toRemove=line
		if !toRemove:
			if instance_from_id(id) ==null :
				continue
			var lockLine_instance = LockLine.instance()
			lockLine_instance.begin_node =  instance_from_id(id).get_path()
			lockLine_instance.end_node = get_node("../DragonManager/dragon_flattened").get_path()
			add_child(lockLine_instance)
#			lockLine_instance.connect("lockLineRemoved", self, "_lockLineRemoved")
		else : 
			remove_child(toRemove)

