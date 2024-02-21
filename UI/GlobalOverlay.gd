extends CanvasLayer

signal exit_pressed

@onready var exit_button = $Panel/ExitButton
@onready var settings_button = $Panel/SettingsButton
@onready var help_button = $Panel/HelpButton
@onready var team_button = $Panel/TeamButton
@onready var logs_button = $Panel/LogsButton

var subview: Control

func present_subview(view):
	if subview != null:
		subview.queue_free()
		if subview.get_script().get_instance_id() == view.get_script().get_instance_id():
			return
	
	add_child(view)
	move_child(view, 1)
	subview = view

func _on_settings_button_pressed():
	var settings =  preload("res://UI/Settings.tscn").instantiate()
	present_subview(settings)

func _on_help_button_pressed():
	var help =  preload("res://UI/Help.tscn").instantiate()
	present_subview(help)

func _on_exit_button_pressed():
	if subview != null:
		subview.queue_free()
		return
	
	exit_pressed.emit()

func _on_team_button_pressed():
	pass # Replace with function body.

func _on_logs_button_pressed():
	pass # Replace with function body.
