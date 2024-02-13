extends Unit
class_name UnitPrime

func _init():
	name = "Prime"
	texture = load("res://Assets/Units/prime.png")
	dmg = 5
	def = 15
	skill = SkillSelfcare.new()
	passive = PassiveEmpty.new()
	tags = ["cyborg", "defender"]
	reroll = 0
