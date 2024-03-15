extends Unit
class_name UnitBeeMech

func _init():
	name = "Bee Mech"
	texture = load("res://Assets/Units/bee_mech.png")
	dmg = 10
	def = 10
	abilities = [
		PassiveAutoHive.new()
	]
	tags = ["bee", "mech"]
	reroll = 0
