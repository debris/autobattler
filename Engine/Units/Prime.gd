extends Unit
class_name UnitPrime

func _init():
	name = "Prime"
	texture = load("res://Assets/Units/prime.png")
	dmg = 5
	def = 15
	abilities = [
		SkillSelfcare.new()
	]
	tags = ["cyborg", "defender"]
	reroll = 0
