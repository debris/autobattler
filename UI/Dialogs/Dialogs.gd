extends Node

func display(dialog_name: String):
	var full_name = "res://UI/Dialogs/" + dialog_name + ".tres"
	var dialog = load(full_name)
	var dialog_control = load("res://UI/Dialog.tscn").instantiate()
	dialog_control.dialog = dialog
	var canvas_layer = CanvasLayer.new()
	canvas_layer.add_child(dialog_control)
	get_tree().root.add_child(canvas_layer)
	dialog_control.next_chapter()
	return dialog_control
