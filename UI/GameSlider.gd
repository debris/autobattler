extends Slider
class_name GameSlider

func _ready():
	mouse_entered.connect(func():
		Sounds.play_hover()
	)

	value_changed.connect(func(_value):
		pass
		#TODO: play music on value change, but in a way that the sound does not play when the
		#slider is initiated first
		#Sounds.play_button_press()
	)
