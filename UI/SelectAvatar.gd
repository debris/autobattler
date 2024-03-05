extends Control

signal action_selected(SelectAvatarAction)

@onready var global_overlay = $GlobalOverlay

var selected_avatar_index: int = 0

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true

func _on_proceed_button_pressed():
	action_selected.emit(SelectAvatarActionProceed.new(null))

func _on_cancel_button_pressed():
	action_selected.emit(SelectAvatarActionCancel.new())
