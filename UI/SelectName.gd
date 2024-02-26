extends Control

signal action_selected(SelectNameAction)

@onready var text_edit = $CenterContainer/GridContainer/TextEdit
@onready var global_overlay = $GlobalOverlay
@onready var name_already_exists = $NameExistsLabel

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true

	text_edit.grab_focus()

func _on_cancel_button_pressed():
	action_selected.emit(SelectNameActionCancel.new())

func _on_proceed_button_pressed():
	proceed(text_edit.text)

func _on_text_edit_text_changed():
	if text_edit.text.contains("\n"):
		var selected_name = text_edit.text.replace("\n", "")
		text_edit.text = selected_name
		text_edit.set_caret_column(selected_name.length())
		proceed(selected_name)
	
	if Save.exists(text_edit.text):
		name_already_exists.visible = true
		return

	name_already_exists.visible = false

func proceed(text):
	if Save.exists(text):
		return

	action_selected.emit(SelectNameActionProceed.new(text))
