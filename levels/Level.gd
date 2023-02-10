extends Spatial
export (int) var bpm = 120


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Settings.bpm = bpm
