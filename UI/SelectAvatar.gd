extends Control

signal action_selected(SelectAvatarAction)

@onready var global_overlay = $GlobalOverlay

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true

func _process(_delta):
	pass
