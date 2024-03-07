# Game panel that has a frame semi transparent background and shines
@tool
extends Control
class_name GamePanel

@export var shine: bool = true:
	set(value):
		shine = value
		if is_node_ready():
			shine_control.visible = shine

var shine_control: Control

func _ready():
	var background: ColorRect = ColorRect.new()
	background.color = Color(0, 0, 0, 180.0/255.0)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.size = size
	background.position = Vector2.ZERO
	background.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	background.size_flags_vertical = Control.SIZE_EXPAND_FILL

	add_child(background)

	var frame = Frame.new()
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	frame.size = size
	frame.position = Vector2.ZERO
	frame.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	frame.size_flags_vertical = Control.SIZE_EXPAND_FILL

	add_child(frame)

	shine_control = preload("res://UI/Shine.tscn").instantiate()
	shine_control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	shine_control.size = size
	shine_control.position = Vector2.ZERO
	shine_control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shine_control.size_flags_vertical = Control.SIZE_EXPAND_FILL
	shine_control.visible = shine

	add_child(shine_control)
