extends Control

@export var queue: Array[BattleUnit]:
	set(value):
		queue = value
		if is_node_ready():
			_update_queue()

@onready var grid = $GridContainer

func _update_queue():
	for i in min(grid.get_child_count(), queue.size()):
		var entry = grid.get_child(i)
		entry.unit = queue[i]

func _ready():
	_update_queue()