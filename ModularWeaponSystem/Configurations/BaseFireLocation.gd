extends Position2D
tool

export var DEBUG: bool = true

func _draw():
	if DEBUG:
		draw_line(Vector2.ZERO, Vector2.RIGHT * 100, Color.steelblue, 4)
		draw_line(Vector2(110, -10), Vector2(90, 10), Color.red, 4)
		draw_line(Vector2(90, -10), Vector2(110, 10), Color.green, 4)
