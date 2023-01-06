extends PlayerState

func update(_delta: float) -> void:
	
	if not player.tween_move.is_active():
		state_machine.transition_to("Idle")

func enter(msg := {}) -> void:
	player.move(msg["dir"])
	
	if msg["dir"] == "ui_left":
		player.skin.flip_h = true
	elif msg["dir"] == "ui_right":
		player.skin.flip_h = false

func exit() -> void:
	pass
