extends Resource
class_name Dialog

@export var avatar: Texture2D
@export var chapters: Array[String]

func _init():
	avatar = null
	chapters = []

#func display(parent: Control):
	## DO NOT PRELOAD, CAUSE IT WILL CREATE CIRCULAR LOAD DEPENDENCY!
	#var dialog_ui = load("res://UI/Dialog.tscn").instantiate()
	#dialog_ui.dialog = self
	#
