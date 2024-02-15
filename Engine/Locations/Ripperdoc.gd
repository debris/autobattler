extends LocationBattle
class_name LocationRipperdoc

func _init():
	name = "Ripperdoc"
	reroll = 80
	icon = load("res://Assets/Icons/ripperdoc.png")
	enemies_pool = Units.cyborgs
