extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			_update_icon()

@export var index: int = 0:
	set(value):
		index = value
		if is_node_ready():
			_update_index()

@onready var icon: TextureRect = $Icon
@onready var index_label: Label = $ColorRect/IndexLabel

func _ready():
	_update_icon()
	_update_index()

func _update_icon():
	if unit != null:
		icon.texture = unit.texture

func _update_index():
	index_label.text = str(index)