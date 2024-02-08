extends Control

@onready var left_button = $Left
@onready var right_button = $Right

func _ready():
	if get_index() == 0:
		left_button.visible = false
	if get_index() == get_parent().get_child_count() - 1:
		right_button.visible = false

func _on_left_pressed():
	BattleController.default().move_unit_left.emit(get_index())

func _on_right_pressed():
	BattleController.default().move_unit_right.emit(get_index())

func _on_change_pressed():
	BattleController.default().change_pressed.emit(get_index())
