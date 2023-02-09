extends Timer



func _ready():
	wait_time = 60/float(Settings.bpm)
	one_shot = false
	autostart = true

func _on_Metronome_timeout():
	get_tree().call_group("BeatListeners","on_beat")

