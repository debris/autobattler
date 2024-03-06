extends Resource
class_name Item

@export var item_name: String
@export var tier: int
# [1-4] properties
@export var properties: Array[ItemProperty]

# needs empty constructor so godot can serialize it
func _init():
	pass