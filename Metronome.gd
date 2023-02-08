extends Timer

export (int) var bpm 

func _ready():
	wait_time = 60/float(bpm)
	one_shot = false
	autostart = true

func _on_Metronome_timeout():
	get_tree().call_group("BeatListeners","on_beat")

