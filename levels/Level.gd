extends Spatial
export (int) var bpm = 120
export (bool) var lerpPitch = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Settings.bpm = bpm
	Settings.lerpPitch = lerpPitch
