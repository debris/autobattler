# Control capable of displaying unit types: `OwnedUnit` and `BattleUnit`
extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()


@onready var unit_control = $CenterContainer/Control/UnitControl

@onready var tags_content = $Control/TagsContent
@onready var tag_underline = $Control/TagsUnderline

@onready var skill_name = $Control/SkillName
@onready var skill_description = $Control/SkillDescription
@onready var skill_underline = $Control/SkillUnderline

@onready var passive_name = $Control/PassiveName
@onready var passive_description = $Control/PassiveDescription
@onready var passive_underline = $Control/PassiveUnderline

@onready var empowered_name = $Control/EmpoweredName
@onready var empowered_counter = $Control/EmpoweredCounter
@onready var empowered_underline = $Control/EmpoweredUnderline

@onready var damage_value = $Control/DamageValue
@onready var defense_value = $Control/DefenseValue

@onready var damage_per_round_value = $Control/DamagePerRoundValue
@onready var defense_per_round_value = $Control/DefensePerRoundValue

func _ready():
	update_display()

func update_display():
	unit_control.unit = unit
	
	tags_content.text = ", ".join(unit.tags.keys())
	skill_name.text = "Activated: " + unit.skill.name
	skill_description.text = tr(unit.skill.description)
	passive_name.text = "Passive: " + unit.passive.name
	passive_description.text = tr(unit.passive.description)
	
	if unit.skill is SkillEmpty:
		skill_name.visible = false
		skill_description.visible = false
		skill_underline.visible = false
	
	if unit.passive is PassiveEmpty:
		passive_name.visible = false
		passive_description.visible = false
		passive_underline.visible = false

	var display_empowered = unit.empowered > 0
	empowered_name.visible = display_empowered
	empowered_counter.visible = display_empowered
	empowered_counter.text = str(unit.empowered)
	empowered_underline.visible = display_empowered

	damage_value.text = str(unit.dmg) 
	defense_value.text = str(unit.def)
	damage_per_round_value.text = "%.1f" % unit.damage_per_round()
	defense_per_round_value.text = "%.1f" % unit.defense_per_round()


func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
