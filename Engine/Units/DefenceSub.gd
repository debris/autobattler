extends Unit
class_name UnitDefenceSub

func _init():
	name = "Defence Sub"
	texture = load("res://Assets/Units/defence_sub.png")
	dmg = 8
	def = 12
	skill = SkillBlue42.new()
	passive = PassiveEmpty.new()
	tags = ["athlete", "defender"]
