extends Unit
class_name UnitDefenceSub

func _init():
	name = "Defence Sub"
	texture = load("res://Assets/Units/defence_sub.png")
	dmg = 8
	def = 12
	abilities = [
		SkillBlue42.new()
	]
	tags = ["athlete", "defender"]
	reroll = 0
