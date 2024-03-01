extends Node
class_name DisplayTooltip

@export var enabled: bool = true:
	set(value):
		enabled = value
		if tooltip != null && !enabled:
			tooltip.queue_free()

@export var side: Side = SIDE_RIGHT:
	set(value):
		side = value
		if tooltip != null:
			_update_tooltip_position()

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
		if !enabled:
			return

		tooltip = preload("Tooltip.tscn").instantiate()
		tooltip.text = text
		TooltipLayer.add_child(tooltip)
		_update_tooltip_position()
	)

	parent.mouse_exited.connect(func():
		if tooltip != null:
			tooltip.queue_free()	
	)

func _update_tooltip_position():
	var parent: Control = get_parent()
	var global_rect = parent.get_global_rect()
	match side:
		Side.SIDE_RIGHT:
			tooltip.global_position = global_rect.position + global_rect.size * Vector2(1, 0.5) + Vector2(8, - tooltip.size.y / 2)
		Side.SIDE_BOTTOM:
			tooltip.global_position = parent.global_position + global_rect.size * Vector2(0.5, 1) + Vector2(-tooltip.size.x / 2, 8)
		Side.SIDE_LEFT:
			tooltip.global_position = global_rect.position + global_rect.size * Vector2(0, 0.5) + Vector2(-tooltip.size.x - 8, - tooltip.size.y / 2)
		Side.SIDE_TOP:
			tooltip.global_position = global_rect.position + global_rect.size * Vector2(0.5, 0) + Vector2(-tooltip.size.x / 2, -tooltip.size.y - 8)
