extends Control

signal play_pressed

func _on_play_button_pressed():
	play_pressed.emit()

func _on_quit_pressed():
	get_tree().quit() 
