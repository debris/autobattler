extends Unit
class_name UnitOrcArcher

func _init():
	name = "Orc Archer"
	texture = load("res://Assets/Units/orc_archer.png")
	dmg = 12
	def = 8
	skill = SkillArcherTraining.new()
	passive = PassiveEmpty.new()
	tags = ["orc", "archer"]
	reroll = 0
