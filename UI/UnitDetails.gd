# Control capable of displaying unit types: `OwnedUnit` and `BattleUnit`
extends Control

@export var unit: Resource:
	set(value):
		unit = value
		if is_node_ready():
			update_display()


@onready var unit_control = $CenterContainer/Control/UnitControl
@onready var tags_content = $Control/TagsContent
@onready var skill_name = $Control/SkillName
@onready var skill_description = $Control/SkillDescription
@onready var passive_name = $Control/PassiveName
@onready var passive_description = $Control/PassiveDescription

func _ready():
	update_display()

func update_display():
	unit_control.unit = unit
	
	tags_content.text = ", ".join(unit.tags.keys())
	skill_name.text = "Active: " + unit.skill.name
	skill_description.text = tr(unit.skill.description)
	passive_name.text = "Passive: " + unit.passive.name
	passive_description.text = tr(unit.passive.description)
	
	if unit.skill is SkillEmpty:
		skill_name.visible = false
		skill_description.visible = false
	
	if unit.passive is PassiveEmpty:
		passive_name.visible = false
		passive_description.visible = false

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
