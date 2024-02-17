extends Control

signal action_selected(SelectNameAction)

@onready var text_edit = $CenterContainer/GridContainer/TextEdit

func _on_cancel_button_pressed():
	action_selected.emit(SelectNameActionCancel.new())

func _on_proceed_button_pressed():
	if Save.exists(text_edit.text):
		return

	action_selected.emit(SelectNameActionProceed.new(text_edit.text))
