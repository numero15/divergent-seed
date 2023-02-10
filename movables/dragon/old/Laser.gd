extends Area

var direction = Vector3.ZERO
var velocity = 30
var target_id =-1
export var damage = 1

func _physics_process(delta):
	  transform.origin += direction * velocity * delta

func _on_Laser_body_entered(body):

	if body.get_instance_id() == target_id :
		body.hurt(damage)
		queue_free()

