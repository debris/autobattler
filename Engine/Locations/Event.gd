extends Location
class_name LocationEvent

func _init():
	name = "Event"
	reroll = 100
	icon = load("res://Assets/Icons/event.png")

func _view() -> Control:
	print_debug("should be overwritten")
	return Control.new()
