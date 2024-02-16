extends Control

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
