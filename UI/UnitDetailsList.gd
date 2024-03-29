extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()

@onready var entries = $ScrollContainer/Control
@onready var tags_content = $ScrollContainer/Control/TagsContent
@onready var tag_underline = $ScrollContainer/Control/TagsUnderline

@onready var empowered_name = $ScrollContainer/Control/EmpoweredName
@onready var empowered_counter = $ScrollContainer/Control/EmpoweredCounter
@onready var empowered_underline = $ScrollContainer/Control/EmpoweredUnderline

@onready var damage_value = $ScrollContainer/Control/DamageValue
@onready var defense_value = $ScrollContainer/Control/DefenseValue

@onready var damage_per_round_value = $ScrollContainer/Control/DamagePerRoundValue
@onready var defense_per_round_value = $ScrollContainer/Control/DefensePerRoundValue

@onready var schedules = $ScrollContainer/Control/Schedules/Schedules
@onready var tiers = $ScrollContainer/Control/Schedules/Tiers

var ability_controls = []

func _ready():
	update_display()

func update_display():
	if unit == null:
		return

	tags_content.text = ", ".join(unit.tags.keys())

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

	for ability in ability_controls:
		ability.queue_free()

	ability_controls.clear()

	for ability in unit.abilities:
		var entry = preload("res://UI/AbilityEntry.tscn").instantiate()
		entry.ability = ability
		ability_controls.push_back(entry)
		entries.add_child(entry)
