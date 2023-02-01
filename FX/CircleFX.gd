extends Spatial
onready var animationPlayer = $AnimationPlayer

func _ready():
	visible = false

func activate():
	visible = true
	animationPlayer.play("CircleFXAnimation")
