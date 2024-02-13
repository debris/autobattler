extends Control

@export var stacks: Stacks:
	set(value):
		stacks = value
		display_stacks()

@onready var grid = $GridContainer

func display_stacks():
	for child in grid.get_children():
		child.queue_free()
	
	for stack_key in stacks.inner.keys():
		var value = stacks.inner[stack_key]
		var label = Label.new()
		grid.add_child(label)

func _process(_delta):
	var keys = stacks.inner.keys()
	for key_index in keys.size():
		var stack_key = keys[key_index]
		var value = stacks.inner[stack_key]
		var label = grid.get_child(key_index)
		label.text = "  " + stack_key + ": " + str(value)
		label.visible = value != 0
