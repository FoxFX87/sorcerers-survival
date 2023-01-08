extends Node2D
class_name ModularWeapon

export var emitter_config: PackedScene setget set_emitter_config
export var projectile_emitter: PackedScene setget set_emitter
export (Array, Resource) var projectile_motions := []

func set_emitter_config(value: PackedScene):
	emitter_config = value
	if not is_inside_tree():
		yield(self, "ready")
		
	clear_emitters()
	add_new_emitters()
	
func set_emitter(value: PackedScene):
	projectile_emitter = value
	set_emitter_config(emitter_config)

func clear_emitters():
	for child in get_children():
		if child is ProjectileEmitter:
			remove_child(child)
			child.queue_free()
			
func add_motion(new_motion: Resource, allows_duplicates: bool  = false):
	if not allows_duplicates:
		var has_motion: bool = false
		for motion in projectile_motions:
			has_motion = new_motion.get_script() == motion.get_script()
			
			if has_motion:
				return
				
	projectile_motions.append(new_motion)

func add_new_emitters():
	var config = emitter_config.instance()
	
	for weapon_position in config.get_children():
		var new_emitter : ProjectileEmitter = projectile_emitter.instance()
		new_emitter.position = weapon_position.position
		new_emitter.rotation = weapon_position.rotation
		
		new_emitter.weapon_system = self
		add_child(new_emitter)
		
	config.free()
