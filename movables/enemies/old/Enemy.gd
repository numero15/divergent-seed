extends KinematicBody

onready var partition = get_node("Partition")

var currentStave
export (int) var health = 4
export (int) var lockLineDuration = 4
export (int) var speed = 0
var damage = 1

func startStave():
#	todo : selection stave methode
	currentStave = partition.get_child(0)
	return currentStave.get_path()

func bullet_intercepted(_targetPath):
	if self.get_path() != _targetPath :
		return
	health-=damage
	if health<1:
		queue_free()


#func bullet_missed():
#	pass

