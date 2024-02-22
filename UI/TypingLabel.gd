@tool
extends Label
class_name TypingLabel

@export_range(0.0, 1.0, 0.01) var percent: float = 0.0:
	set(value):
		percent = value
		if is_node_ready():
			update_display()

@export var final_text: String:
	set(value):
		final_text = value
		if is_node_ready():
			update_display()

func update_display():
	var to_display = int(final_text.length() * percent)
	text = final_text.substr(0, to_display)

func _ready():
	update_display()
