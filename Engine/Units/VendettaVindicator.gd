extends Unit
class_name UnitVendettaVindicator

func _init():
	name = "V. Vindicator"
	texture = load("res://Assets/Units/vendetta_vindicator.png")
	dmg = 12
	def = 8
	abilities = [
		PassiveRetribution.new()
	]
	tags = ["cyborg"]
	reroll = 0
