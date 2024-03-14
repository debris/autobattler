# Control capable of displaying unit types: `OwnedUnit` and `BattleUnit`
extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()


@onready var unit_control = $CenterContainer/Control/UnitControl
@onready var unit_details_list = $UnitDetailsList

func _ready():
	update_display()

func update_display():
	unit_control.unit = unit
	unit_details_list.unit = unit
	
func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
