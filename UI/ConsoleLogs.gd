extends CanvasLayer

@export var battle_state: BattleState

@onready var list_control = $Control/ScrollContainer/GridContainer

var displayed_logs = 0

func _process(delta):
	if displayed_logs < battle_state.logs.size():
		_display_log("=========================")
		_display_log("ROUND: " + str(battle_state.round) + ", PHASE: " + str(battle_state.phase))
	
	while displayed_logs < battle_state.logs.size():
		var log = battle_state.logs[displayed_logs]
		_display_log(log._to_string() + log._display_is_valid())
		displayed_logs += 1

# private
func _display_log(text: String):
	var label = Label.new()
	label.text = text
	label.custom_minimum_size = Vector2(0, 20)
	label.add_theme_color_override("font_color", Color.WHITE)
	label.add_theme_font_size_override("font_size", 14)
	list_control.add_child(label)
	list_control.move_child(label, 0)
