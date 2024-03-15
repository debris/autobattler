extends Unit
class_name UnitGreenscale

func _init():
	name = "Greenscale"
	texture = load("res://Assets/Units/greenscale.png")
	dmg = 10
	def = 10
	abilities = [
		SkillBrimstoneCurse.new()
	]
	tags = ["dragon", "god"]
	reroll = 30
