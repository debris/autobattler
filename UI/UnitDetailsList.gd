extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()

@onready var tags_content = $ScrollContainer/Control/TagsContent
@onready var tag_underline = $ScrollContainer/Control/TagsUnderline

@onready var skill_name = $ScrollContainer/Control/SkillName
@onready var skill_description = $ScrollContainer/Control/SkillDescription
@onready var skill_underline = $ScrollContainer/Control/SkillUnderline

@onready var passive_name = $ScrollContainer/Control/PassiveName
@onready var passive_description = $ScrollContainer/Control/PassiveDescription
@onready var passive_underline = $ScrollContainer/Control/PassiveUnderline

@onready var empowered_name = $ScrollContainer/Control/EmpoweredName
@onready var empowered_counter = $ScrollContainer/Control/EmpoweredCounter
@onready var empowered_underline = $ScrollContainer/Control/EmpoweredUnderline

@onready var damage_value = $ScrollContainer/Control/DamageValue
@onready var defense_value = $ScrollContainer/Control/DefenseValue

@onready var damage_per_round_value = $ScrollContainer/Control/DamagePerRoundValue
@onready var defense_per_round_value = $ScrollContainer/Control/DefensePerRoundValue

@onready var schedules = $ScrollContainer/Control/Schedules/Schedules
@onready var tiers = $ScrollContainer/Control/Schedules/Tiers

func _ready():
	update_display()

func update_display():
	if unit == null:
		return

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

	var schedule_controls = schedules.get_children()
	for i in 3:
		schedule_controls[i].schedule = unit.schedules[i]
	tiers.schedules = unit.schedules