extends OptionButton
class_name GameOptionButton

func _ready():
	mouse_entered.connect(func():
		if !disabled:
			Sounds.play_hover()
	)
	
	#TODO: play sound on value selection
