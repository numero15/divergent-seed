extends Node3D

@export  var pivot:NodePath
@export var r = 2.0
@export var theta = .5
@export var phi = 1.0
var _ori = Vector3.ZERO

func _ready():
	_ori = Vector3(r*sin(phi)*cos(theta),r*sin(phi)*sin(theta),r*cos(phi))
	transform.origin = _ori

func _process(delta):
	theta = theta+1*delta
	phi = phi+1*delta
	_ori = Vector3(r*sin(phi)*cos(theta),r*sin(phi)*sin(theta),r*cos(phi))
	transform.origin = _ori
	_ori = _ori.normalized()
	look_at(get_node(pivot).global_transform.origin,Vector3.UP)
