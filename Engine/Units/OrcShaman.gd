extends Unit
class_name UnitOrcShaman

func _init():
	name = "Orc Shaman"
	texture = load("res://Assets/Units/orc_shaman.png")
	dmg = 8
	def = 12
	skill = SkillDefenceRitual.new()
	passive = PassiveEmpty.new()
	tags = ["orc", "shaman"]
	reroll = 0
