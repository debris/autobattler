extends Unit
class_name UnitArzog

func _init():
	name = "Arzog"
	texture = load("res://Assets/Units/arzog.png")
	dmg = 10
	def = 10
	abilities = [
		SkillDivineBlessing.new()
	]
	tags = ["god"]
	reroll = 80