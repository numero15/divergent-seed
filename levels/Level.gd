extends Node3D
@export var bpm:int = 120
@export  var lerpPitch:bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Settings.bpm = bpm
	Settings.lerpPitch = lerpPitch
