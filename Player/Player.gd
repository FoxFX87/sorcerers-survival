extends KinematicBody2D
class_name Player

const GRID_SIZE = 16

const INPUTS = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

const SPELL_INPUTS = [
	"east_cast",
	"west_cast",
	"north_cast",
	"south_cast"
]

const GREENSPELL = preload("res://SpellAttacks/SpellWindBlase.tscn")

export (float) var move_speed: float = 10

onready var skin = $Skin
onready var move_ray_cast = $MoveRayCast
onready var tween_move = $TweenMove
onready var east_spell_locator = $EastSpellLocator
onready var west_spell_locator = $WestSpellLocator
onready var north_spell_locator = $NorthSpellLocator
onready var south_spell_locator = $SouthSpellLocator

func _enter_tree():
	MainInstances.player = self
	
func _exit_tree():
	MainInstances.player = null

func _ready():
	snap_to_grid()

func _process(_delta):
	update_visible_locators()
	
func update_visible_locators():
	var locators = [
		east_spell_locator,
		west_spell_locator,
		north_spell_locator,
		south_spell_locator
	]
	
	for locator in locators:
		locator.visible = locator.is_colliding()
		
	
func hide_locators():
	var locators = [
		east_spell_locator,
		west_spell_locator,
		north_spell_locator,
		south_spell_locator
	]
	
	for locator in locators:
		locator.visible = false
		
	
func can_cast(spell_string: String):
	var _locators = [
		east_spell_locator,
		west_spell_locator,
		north_spell_locator,
		south_spell_locator
	]
	
	match spell_string:
		"east_cast":
			if east_spell_locator.is_colliding():
				consume_for_spell(east_spell_locator)
			
		"west_cast":
			if west_spell_locator.is_colliding():
				consume_for_spell(west_spell_locator)
			
		"north_cast":
			if north_spell_locator.is_colliding():
				consume_for_spell(north_spell_locator)
			
		"south_cast":
			if south_spell_locator.is_colliding():
				consume_for_spell(south_spell_locator)
				

func consume_for_spell(spell_collider: RayCast2D):
	spell_collider.get_collider().queue_free()
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
