extends Location
class_name LocationBattle

var enemies_pool: Array[Unit]

func _init():
	name = "Battle"
	reroll = 0
	icon = load("res://Assets/Icons/battle.png")
	enemies_pool = Units.all
