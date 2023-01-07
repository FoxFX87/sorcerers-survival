extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	
	for direction in player.INPUTS.keys():
		if Input.is_action_pressed(direction):
			state_machine.transition_to("Move", {dir = direction})
	
	for cast in player.SPELL_INPUTS:
		if Input.is_action_just_pressed(cast):
			player.can_cast(cast)
			player.hide_locators()
			player.update_visible_locators()
	

func enter(_msg := {}) -> void:
	player.update_visible_locators()
	pass

func exit() -> void:
	player.hide_locators()
	pass
