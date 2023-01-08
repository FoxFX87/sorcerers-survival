extends Node2D
class_name ProjectileEmitter

export var damage_per_hit : int = 5
export var projectile_per_sec : float = 1.0
export var projectile_lifetime : float = 1.0

var weapon_system: Node

onready var spawn_parent: Node = get_tree().root

func fire():
	do_fire(
		Vector2.RIGHT.rotated(global_rotation),
		weapon_system.projectile_motions,
		projectile_lifetime
	)
	
func do_fire(_direction: Vector2, _motions: Array, _lifetime: float):
	pass
