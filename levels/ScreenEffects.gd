extends ColorRect
@onready var animationPlayer = get_node("AnimationPlayer")


func bullet_intercepted(_targetPath):
	pass

func bullet_missed(_targetPath):
	animationPlayer.play("ChromaticFlash")
	pass
