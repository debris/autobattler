extends Control

@export var queue: Array[QueuePosition]:
	set(value):
		var old_queue = queue
		queue = value
		if is_node_ready():
			_update_queue(old_queue)

@onready var grid = $Grid

func _update_queue(old_queue):
	var find_value_in = func(value, collection):
		var index = 0;
		for i in collection:
			if i.is_equal(value):
				return index
			index += 1
		return -1

	var old_indexes = queue.map(func(value): return find_value_in.call(value, old_queue))

	# first clear!
	for child in grid.get_children():
		child.queue_free()
	
	for i in queue.size():
		var entry_scale = Vector2.ONE

		if i == 0:
			entry_scale = Vector2(1.2, 1.2)

		# NEW entry
		if old_indexes[i] == -1:
			var entry = preload("res://UI/QueueEntry.tscn").instantiate()
			entry.position = _position_for_index(i, true)
			entry.unit = queue[i].unit
			entry.index = i + 1
			entry.skill_kind = queue[i].skill_kind
			entry.scale = entry_scale
			grid.add_child(entry)
			_move_to_index(entry, i)
		# OLD entry
		else:
			var entry = preload("res://UI/QueueEntry.tscn").instantiate()
			entry.position = _position_for_index(old_indexes[i])
			entry.unit = queue[i].unit
			entry.index = i + 1
			entry.skill_kind = queue[i].skill_kind
			entry.scale = entry_scale
			grid.add_child(entry)
			_move_to_index(entry, i)

func _position_for_index(index: int, is_new: bool = false) -> Vector2:
	const OFFSET: float = 72.0
	const SIZE: float = 64.0
	const SPACE: float = 8.0

	var scale_offset = min(1, index) * 8.0

	var position_y = OFFSET + (SIZE + SPACE) * index + scale_offset
	var entry_position = Vector2(4.0, position_y)
	if is_new:
		entry_position.x += 80
	return entry_position


func _move_to_index(entry, index: int):
	var entry_position = _position_for_index(index)
	var tween = entry.create_tween()
	tween.tween_property(entry, "position", entry_position, DisplaySettings.default().step_time / 2)

func _ready():
	_update_queue([])