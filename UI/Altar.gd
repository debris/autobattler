extends Control

signal proceed

@export var save: Save

@onready var global_overlay = $GlobalOverlay
@onready var empowered_unit_control = $GridContainer/EmpoweredUnitControl
@onready var sacrificed_unit_control = $GridContainer/SacrificedUnitControl

@onready var select_empowered_button = $GridContainer/SelectEmpowered
@onready var select_sacrificed_button = $GridContainer/SelectSacrificed

@onready var sacrifice_button = $GridContainer2/SacrificeButton
@onready var proceed_button = $GridContainer2/ProceedButton
@onready var animation_player = $AnimationPlayer

var empowered_unit: BattleUnit
var sacrificed_unit: BattleUnit

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.help_button.visible = true
	sacrifice_button.disabled = true
	sacrifice_button.focus_mode = FOCUS_NONE

func update_sacrifice_button():
	if empowered_unit != null && sacrificed_unit != null:
		sacrifice_button.focus_mode = FOCUS_ALL
		sacrifice_button.disabled = false

func _on_select_empowered_pressed():
	var list = preload("res://UI/UnitList.tscn").instantiate()
	var units = save.all_units().filter(func(unit):
		return sacrificed_unit == null || sacrificed_unit.unit.get_instance_id() != unit.get_instance_id()
	).collect().map(func(unit): return BattleUnit.new(unit, save.player_team_level))
	list.units.assign(units)
	list.selected_unit.connect(func(index):
		empowered_unit = units[index]
		empowered_unit_control.unit = empowered_unit
		list.queue_free()
		update_sacrifice_button()
	)
	global_overlay.present_subview(list)

func _on_select_sacrificed_pressed():
	var list = preload("res://UI/UnitList.tscn").instantiate()
	var units = save.all_units().filter(func(unit):
		return empowered_unit == null || empowered_unit.unit.get_instance_id() != unit.get_instance_id()
	).collect().map(func(unit): return BattleUnit.new(unit, save.player_team_level))
	list.units.assign(units)
	list.selected_unit.connect(func(index):
		sacrificed_unit = units[index]
		sacrificed_unit_control.unit = sacrificed_unit
		list.queue_free()
		update_sacrifice_button()
	)
	global_overlay.present_subview(list)

func _on_sacrifice_button_pressed():
	if empowered_unit != null && sacrificed_unit != null:
		sacrifice_button.visible = false
		select_sacrificed_button.visible = false
		select_empowered_button.visible = false
		animation_player.play("sacrifice")
		await animation_player.animation_finished
		if empowered_unit != null:
			empowered_unit.unit.empowered += 1
			empowered_unit_control.unit = BattleUnit.new(empowered_unit.unit, save.player_team_level)
			save.delete_unit(sacrificed_unit.unit)
			proceed_button.text = "PROCEED"

# called by sacrifice animation
func _reset_sacrifice_control():
	sacrificed_unit_control.unit = null

func _on_proceed_button_pressed():
	proceed.emit()
