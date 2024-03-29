extends Control

signal action_selected(SelectAvatarAction)

@onready var global_overlay = $GlobalOverlay

var selected_avatar: Avatar

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true

func _on_proceed_button_pressed():
	action_selected.emit(SelectAvatarActionProceed.new(selected_avatar))

func _on_cancel_button_pressed():
	action_selected.emit(SelectAvatarActionCancel.new())


func _on_avatars_selected(avatar: Avatar):
	selected_avatar = avatar
