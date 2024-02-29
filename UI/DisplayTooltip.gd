extends Node
class_name DisplayTooltip

@export var text: String:
	set(value):
		text = value
		if tooltip != null:
			tooltip.text = text

var tooltip: Label:
	set(value):
		if tooltip != null:
			tooltip.queue_free()
		tooltip = value		

func _ready():
	var parent: Control = get_parent()
	parent.mouse_entered.connect(func(): 
		tooltip = preload("Tooltip.tscn").instantiate()
		tooltip.text = text
		tooltip.position = parent.size * Vector2(1, 0.5) + Vector2(8, - tooltip.size.y / 2)
		parent.add_child(tooltip)
	)

	parent.mouse_exited.connect(func():
		tooltip.queue_free()	
	)
