extends LocationBattle
class_name LocationCircus

func _init():
	name = "Circus"
	reroll = 80
	icon = load("res://Assets/Icons/circus.png")
	enemies_pool = Units.tricksters
