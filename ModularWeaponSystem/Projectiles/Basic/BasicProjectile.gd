extends Projectile

onready var timer: Timer = $Timer

func post_setup():
	if not is_inside_tree():
		yield(self, "ready")
	timer.start(lifetime)
	
func _on_Timer_timeout():
	queue_free()

func _physics_process(delta):
	var movement = update_movement(delta)
	var collision = move_and_collide(movement)
	
	if collision:
		queue_free()
