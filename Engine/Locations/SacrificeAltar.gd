extends LocationEvent
class_name LocationSacrificeAltar

func _init():
	name = "Event"
	reroll = 0
	icon = load("res://Assets/Icons/event.png")

func _view() -> Control:
	var altar = load("res://UI/Altar.tscn").instantiate()
	return altar
