extends Spatial

var LockLine = preload("res://LockLine.tscn")
var first_lock = false
signal setZoom

func add_lines(_ids:Array):
	
	var toRemove = null
	
	if get_child_count()==0 : first_lock = true
	for id in _ids: 
		toRemove = null
		for line in get_children():
			if get_node(line.begin_node).get_instance_id() == id :
				toRemove=line
		if !toRemove:
			var lockLine_instance = LockLine.instance()
			lockLine_instance.begin_node =  instance_from_id(id).get_path()
			lockLine_instance.end_node = get_node("../DragonManager/dragon_flattened").get_path()
			add_child(lockLine_instance)
		else : 
			remove_child(toRemove)
		
#		send zoom signal if first lock	
		if first_lock and get_child_count()!=0 : emit_signal("setZoom",true)
		
#		send dezoom signal if last lock ended
		if !first_lock and get_child_count()==0 : emit_signal("setZoom",false)
				
		if get_child_count()==0 : first_lock = true
		else : first_lock = false
