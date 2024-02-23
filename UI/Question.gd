extends Control

signal cancel_pressed
signal yes_pressed

@export var question_text: String:
	set(value):
		question_text = value
		if is_node_ready():
			update_display()

@onready var question_label = $CenterContainer/GridContainer/QuestionLabel

func update_display():
	question_label.text = question_text

func _ready():
	update_display()

func _on_cancel_button_pressed():
	cancel_pressed.emit()

func _on_yes_button_pressed():
	yes_pressed.emit()
