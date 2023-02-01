extends KinematicBody

export var health = 100
var damage = 5


func bullet_intercepted(_targetPath):
	if self.get_path() != _targetPath :
		return
	health-=damage
	if health<1:
		queue_free()

func bullet_missed():
	pass

