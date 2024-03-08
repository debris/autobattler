extends Avatar
class_name AvatarChotu8F

func _init():
	name = "Chotu 8-F"
	texture = load("res://Assets/UnitsTransparent/chotu_4_f.png")
	bio = "Blue is the color of the sky."
	ability = "Whenever allied unit activates a skill, get 10 percent of units defense as power."
	# TODO: consider owned units with predefined schedules
	starting_units = [
		UnitAzureDragon.new(),
		UnitArzog.new()
	]
