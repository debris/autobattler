extends Unit
class_name UnitLeyla

func _init():
	name = "Leyla"
	texture = load("res://Assets/Units/leyla.png")
	dmg = 12
	def = 8
	skill = SkillEmpty.new()
	passive = PassiveCyberstrike.new()
	tags = ["cyborg", "assassin"]
	reroll = 0
