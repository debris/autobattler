extends Button
class_name GameButton

func _ready():
	mouse_entered.connect(func():
		if !disabled:
			Sounds.play_hover()
	)
	pressed.connect(func():
		Sounds.play_button_press()
	)
