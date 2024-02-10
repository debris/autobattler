extends CanvasLayer

@export var battle_state: BattleState:
	set(value):
		battle_state = value
		logs_iterator = LogsIterator.new(battle_state).peekable()

@onready var list_control = $Control/ScrollContainer/GridContainer

var logs_iterator

func _process(_delta):
	if logs_iterator.peek() != null:
		_display_log("=========================")
		_display_log("ROUND: " + str(battle_state.round) + ", PHASE: " + str(battle_state.phase))
	
	logs_iterator.for_each(func(battle_log):
		_display_log(battle_log._to_string() + battle_log._display_is_valid())
	)

# private
func _display_log(text: String):
	var label = Label.new()
	label.text = text
	label.custom_minimum_size = Vector2(0, 20)
	label.add_theme_color_override("font_color", Color.WHITE)
	label.add_theme_font_size_override("font_size", 18)
	label.add_theme_font_override("font", preload("res://Assets/Fonts/data-latin.ttf"))
	list_control.add_child(label)
