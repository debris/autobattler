@tool
extends Control
class_name ImageRect

@export var texture: Texture2D:
	set(value):
		if texture != value:
			texture = value
			queue_redraw()

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	focus_mode = Control.FOCUS_NONE
	process_mode = Node.PROCESS_MODE_DISABLED

func _draw():
	if texture != null:
		draw_texture_rect(texture, Rect2(Vector2.ZERO, size), false, modulate)
