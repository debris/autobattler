extends Control

signal selected_unit(unit_index: int)

@export var units: Array[OwnedUnit]

@onready var list = $ScrollContainer/GridContainer

func _ready():
	for unit in units:
		var entry = preload("res://UI/UnitListEntry.tscn").instantiate()
		entry.unit = unit
		entry.selected.connect(func():
			selected_unit.emit(entry.get_index())
		)
		list.add_child(entry)

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
