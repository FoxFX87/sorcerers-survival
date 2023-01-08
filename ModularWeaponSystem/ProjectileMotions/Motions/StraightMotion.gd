extends ProjectileMotion
class_name StraightMotion

export var travel_speed : float = 300.0

func update_movement(_direction: Vector2, _delta: float) -> Vector2:
	return _direction * travel_speed * _delta
