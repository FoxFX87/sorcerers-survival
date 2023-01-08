extends KinematicBody2D
class_name Projectile

var lifetime: float = 1.0
var motions: Array = []
var direction: Vector2 = Vector2.RIGHT
var is_setup: bool = false

func setup(start_position: Vector2, start_direction: Vector2, motion_list: Array, start_lifetime: float):
	self.position = start_position
	self.direction = start_direction
	self.lifetime = start_lifetime
	
	if not is_setup:
		for motion in motion_list:
			var new_motion = motion.duplicate()
			new_motion.projectile = self
			motions.append(new_motion)
			
		is_setup = true
		
	post_setup()

func post_setup():
	pass

func update_movement(delta: float) -> Vector2:
	var movement_vector: Vector2 = Vector2.ZERO
	
	if motions.empty():
		return movement_vector
		
	for motion in motions:
		movement_vector += motion.update_movement(direction, delta)
		
	return movement_vector
		
	
