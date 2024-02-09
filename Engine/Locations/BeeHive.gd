extends LocationBattle
class_name LocationBeeHive

func _init():
	name = "Bee Hive"
	reroll = 80
	icon = load("res://Assets/Icons/bee_hive.png")
	enemies_pool = Units.bees
