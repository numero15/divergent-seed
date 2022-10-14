extends Spatial

var transformArray = []
onready var prim = get_node("ImmediateGeometry")
onready var skeleton = get_node("trailMesh/Armature/Skeleton")
onready var dragon = get_node("../dragon_flattended")

var ori

func _process(delta):

	if(transformArray.size()>119):
		prim.begin(Mesh.PRIMITIVE_LINE_STRIP)
		for i in transformArray.size()-2:
			if i%10 ==0 :
				prim.add_vertex(transformArray[i].origin)
				prim.add_vertex(transformArray[i+1].origin)
		prim.end()
	
func updatePos(_trans):
	transformArray.push_front (_trans)
	if(transformArray.size()>120):
		transformArray.pop_back()
	

