extends Avatar
class_name AvatarFatherPiet

func _init():
	name = "Father Piet"
	texture = load("res://Assets/UnitsTransparent/father_piet.png")
	bio = "For those who sin."
	ability = "TODO"
	starting_units = [
		OwnedUnit.new(UnitNova.new()),
		OwnedUnit.new(UnitOtis.new())
	]