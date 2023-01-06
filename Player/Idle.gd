extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	
	for direction in player.INPUTS.keys():
		if Input.is_action_pressed(direction):
			state_machine.transition_to("Move", {dir = direction})
	
	if player.can_cast_east():
		player.consume_east()

func enter(_msg := {}) -> void:
	pass
