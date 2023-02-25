extends Node3D

#@onready var dragon_mesh = get_node("dragon_flattened/Armature/Skeleton3D")
#@onready var trail_left = get_node("TrailLeft")
#@onready var trail_right = get_node("TrailRight")

func _physics_process(delta):
#	trail_left.transform = dragon_mesh.global_transform*dragon_mesh.get_bone_global_pose(dragon_mesh.find_bone("Digit.003.L.004"))
#	trail_right.transform = dragon_mesh.global_transform*dragon_mesh.get_bone_global_pose(dragon_mesh.find_bone("Digit.003.R.004"))
