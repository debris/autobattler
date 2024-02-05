extends Control

@export var battle_query: BattleQuery:
	set(value):
		battle_query = value
		if battle_unit_control != null:
			battle_unit_control.battle_query = battle_query

@onready var battle_unit_control = $CenterContainer/Control/BattleUnitControl
@onready var skill_name = $Control/SkillName
@onready var skill_description = $Control/SkillDescription
@onready var passive_name = $Control/PassiveName
@onready var passive_description = $Control/PassiveDescription

func _ready():
	battle_unit_control.battle_query = battle_query
	battle_unit_control.click_to_show_details = false
	battle_unit_control.with_battle_logs = false
	
	var unit = battle_query.get_this_unit()
	
	skill_name.text = "Active: " + unit.skill.name
	skill_description.text = unit.skill.description
	passive_name.text = "Passive: " + unit.unit.base.passive.name
	passive_description.text = unit.unit.base.passive.description
	
	if unit.skill is SkillEmpty:
		skill_name.visible = false
		skill_description.visible = false
	
	if unit.unit.base.passive is PassiveEmpty:
		passive_name.visible = false
		passive_description.visible = false

func _input(event):
	if event.is_action_released("LeftClick"):
		var mouse_position = get_global_mouse_position()
		var rect = get_global_rect()
		if rect.has_point(mouse_position):
			accept_event()
			queue_free()
