extends LocationEvent
class_name LocationSacraficeAltar

func _init():
	name = "Event"
	reroll = 95
	icon = load("res://Assets/Icons/event.png")

func _view() -> Control:
	var altar = load("res://UI/Altar.tscn").instantiate()
	return altar
