extends Unit
class_name UnitBaldBarney

func _init():
	name = "Bald Barney"
	texture = load("res://Assets/Units/bald_barney.png")
	dmg = 10
	def = 10
	abilities = [
		PassiveSuicideAttempt.new()
	]
	tags = ["trickster"]
	reroll = 0