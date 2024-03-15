extends Control

@export var ability: Ability:
	set(value):
		ability = value
		if is_node_ready():
			update_display()

@onready var ability_name = $Name
@onready var description = $Description

func _ready():
	update_display()

func update_display():
	var prefix = ""
	if is_instance_of(ability, Skill):
		prefix = "ACTIVATED"
	else:
		prefix = "PASSIVE"

	ability_name.text = prefix + ": " + ability.name
	description.text = ability.description