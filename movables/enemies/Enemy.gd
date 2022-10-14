extends KinematicBody

export var health = 100


func hurt(damage):
	health-=damage
	if health<1:
		queue_free()
