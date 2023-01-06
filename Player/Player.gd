extends KinematicBody2D
class_name Player

const GRID_SIZE = 16

const INPUTS = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

const GREENSPELL = preload("res://SpellAttacks/SpellWindBlase.tscn")

export (float) var move_speed: float = 10

onready var skin = $Skin
onready var move_ray_cast = $MoveRayCast
onready var tween_move = $TweenMove
onready var east_spell_locator = $EastSpellLocator

var has_right_spell: bool = false

func _ready():
	snap_to_grid()

func _process(_delta):
	east_spell_locator.visible = east_spell_locator.is_colliding()

func can_cast_east():
	return Input.is_action_just_pressed("in_cast_east_spell") and east_spell_locator.is_colliding()

func consume_east():
	east_spell_locator.get_collider().queue_free()
	var spell = GREENSPELL.instance()
	spell.global_position = self.global_position
	get_tree().root.add_child(spell)

func snap_to_grid():
	position = position.snapped(Vector2.ONE * GRID_SIZE)
	position -= Vector2.ONE * GRID_SIZE/2
	
func move(direction):
	move_ray_cast.cast_to = INPUTS[direction] * GRID_SIZE
	move_ray_cast.force_raycast_update()

	if not move_ray_cast.is_colliding():
		tween_move.interpolate_property(
			self,
			"position",
			position,
			position + INPUTS[direction] * GRID_SIZE,
			1.0 / move_speed,
			Tween.TRANS_SINE
		)
		tween_move.start()
		
#		var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
#		tween.tween_property(
#			self,
#			"position",
#			position + INPUTS[direction] * GRID_SIZE,
#			1.0 / move_speed
#		)
