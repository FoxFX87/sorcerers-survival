extends ProjectileEmitter

var projectile = preload("res://ModularWeaponSystem/Projectiles/Basic/BasicProjectile.tscn")

onready var timer = $Timer

func _unhandled_input(event):
	
	if event.is_action("ui_accept") and timer.is_stopped():
		fire()
		timer.start(1.0/projectile_per_sec)
		
func do_fire(_direction: Vector2, _motions: Array, _lifetime: float):
	if not spawn_parent:
		return
		
	var new_projectile = projectile.instance()
	new_projectile.setup(global_position, _direction, _motions, _lifetime)
	spawn_parent.add_child(new_projectile)
