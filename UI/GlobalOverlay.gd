extends CanvasLayer

func _on_settings_button_pressed():
	var settings =  preload("res://UI/Settings.tscn").instantiate()
	add_child(settings)

func _on_help_button_pressed():
	var help =  preload("res://UI/Help.tscn").instantiate()
	add_child(help)
