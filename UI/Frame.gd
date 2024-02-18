@tool
extends Control
class_name Frame

func _draw():
	var inner_color = Color(60.0/255.0, 60.0/255.0, 60.0/255.0)
	var outer_color = Color(15.0/255.0, 15.0/255.0, 15.0/255.0)
	var width = 1.0
	var offset = Vector2(width, width)
	draw_rect(Rect2(Vector2.ZERO, size), outer_color, false, width)
	draw_rect(Rect2(Vector2.ZERO + offset, size - offset * 2), inner_color, false, width)
