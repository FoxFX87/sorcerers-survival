extends Control

onready var north_label = $Center/NorthInput/NorthLabel
onready var south_label = $Center/SouthInput/SouthLabel
onready var east_label = $Center/EastInput/EastLabel
onready var west_label = $Center/WestInput/WestLabel
onready var player = MainInstances.player as Player

func _process(_delta):
	_update_text()

func _update_text():
	
	if player == null:
		return
		
	north_label.visible = player.north_spell_locator.is_colliding()
	south_label.visible = player.south_spell_locator.is_colliding()
	east_label.visible = player.east_spell_locator.is_colliding()
	west_label.visible = player.west_spell_locator.is_colliding()
