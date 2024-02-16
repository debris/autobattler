extends CanvasLayer

func _on_settings_button_pressed():
	var settings =  preload("res://UI/Settings.tscn").instantiate()
	add_child(settings)
