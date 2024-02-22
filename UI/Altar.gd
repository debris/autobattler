extends Control

signal proceed

@export var save: Save

@onready var empowered_unit_control = $CenterContainer/GridContainer2/GridContainer/EmpoweredUnitControl
@onready var sacrificed_unit_control = $CenterContainer/GridContainer2/GridContainer/SacrificedUnitControl
@onready var global_overlay = $GlobalOverlay

var empowered_unit: OwnedUnit
var sacrificed_unit: OwnedUnit

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.help_button.visible = true

func _on_select_empowered_pressed():
	var list = preload("res://UI/UnitList.tscn").instantiate()
	var units = save.all_units().filter(func(unit):
		return sacrificed_unit == null || sacrificed_unit.get_instance_id() != unit.get_instance_id()
	).collect()
	list.units.assign(units)
	list.selected_unit.connect(func(index):
		empowered_unit = units[index]
		empowered_unit_control.unit = empowered_unit
		list.queue_free()
	)
	global_overlay.present_subview(list)


func _on_select_sacrificed_pressed():
	var list = preload("res://UI/UnitList.tscn").instantiate()
	var units = save.all_units().filter(func(unit):
		return empowered_unit == null || empowered_unit.get_instance_id() != unit.get_instance_id()
	).collect()
	list.units.assign(units)
	list.selected_unit.connect(func(index):
		sacrificed_unit = units[index]
		sacrificed_unit_control.unit = sacrificed_unit
		list.queue_free()
	)
	global_overlay.present_subview(list)

func _on_sacrifice_button_pressed():
	if empowered_unit != null && sacrificed_unit != null:
		empowered_unit.empowered += 1
		save.delete_unit(sacrificed_unit)
		proceed.emit()


func _on_cancel_button_pressed():
	proceed.emit()
