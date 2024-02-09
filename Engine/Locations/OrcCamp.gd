extends LocationBattle
class_name LocationOrcCamp

func _init():
	name = "Orc Camp"
	reroll = 80
	icon = load("res://Assets/Icons/orc_camp.png")
	enemies_pool = Units.orcs
