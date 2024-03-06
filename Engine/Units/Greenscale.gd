extends Unit
class_name UnitGreenscale

func _init():
	name = "Greenscale"
	texture = load("res://Assets/Units/greenscale.png")
	dmg = 10
	def = 10
	skill = SkillBrimstoneCurse.new()
	passive = PassiveEmpty.new()
	tags = ["dragon", "god"]
	reroll = 30
