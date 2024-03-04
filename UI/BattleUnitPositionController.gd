extends Control

@onready var content = $Content
@onready var left_button = $Content/Grid/Left
@onready var right_button = $Content/Grid/Right

func _ready():
	content.visible = false
	z_index = 1

	if get_index() == 0:
		left_button.visible = false
	if get_index() == get_parent().get_child_count() - 1:
		right_button.visible = false

	mouse_entered.connect(func():
		content.visible = true
	)

	mouse_exited.connect(func():
		content.visible = false
	)
	
func _on_left_pressed():
	BattleController.default().move_unit_left.emit(get_index())
	release_focus()

func _on_right_pressed():
	BattleController.default().move_unit_right.emit(get_index())
	release_focus()

func _on_change_pressed():
	BattleController.default().change_pressed.emit(get_index())
	release_focus()

func _input(_event):
	# mouse filter pass doesnt work so lets work around it #so dummy
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	content.visible = rect.has_point(mouse_position)
