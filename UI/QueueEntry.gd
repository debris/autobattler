extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			_update_icon()

@onready var icon: TextureRect = $Icon

func _ready():
	_update_icon()

func _update_icon():
	if unit != null:
		icon.texture = unit.texture