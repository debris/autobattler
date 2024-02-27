extends Control

@export var font_size: int = 6:
	set(value):
		font_size = value
		if is_node_ready():
			_update_font_size()

@export var schedules: Array[Schedule]

@onready var grid = $GridContainer

func _ready():
	_update_font_size()

func _update_font_size():
	for i in 3:
		var label: Label = grid.get_child(i)
		label.add_theme_font_size_override("font_size", font_size)

func _process(_delta):
	if schedules.size() > 0:
		for i in 3:
			grid.get_child(i).schedule = schedules[i]