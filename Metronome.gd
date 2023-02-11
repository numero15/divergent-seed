extends Timer



func _ready():
	wait_time = 60/float(Settings.bpm)/4
	one_shot = false
	autostart = true

func _on_Metronome_timeout():
	wait_time = 60/float(Settings.bpm)/4
	get_tree().call_group("BeatListeners","on_beat")

