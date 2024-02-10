extends LocationBattle
class_name LocationVikingBoat

func _init():
	name = "Viking Boat"
	reroll = 80
	icon = load("res://Assets/Icons/viking_boat.png")
	enemies_pool = Units.vikings
