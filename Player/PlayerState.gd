extends State
class_name PlayerState

# Typed reference to the player node.
var player: Player


func _ready() -> void:
	yield(owner, "ready")
	player = owner as Player
	assert(player != null)
