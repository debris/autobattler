extends Control

signal cancel_pressed
signal yes_pressed

func _on_cancel_button_pressed():
	cancel_pressed.emit()

func _on_yes_button_pressed():
	yes_pressed.emit()
