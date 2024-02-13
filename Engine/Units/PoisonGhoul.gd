extends Unit
class_name UnitPoisonGhoul

func _init():
	name = "Poison Ghoul"
	texture = load("res://Assets/Units/poison_ghoul.png")
	dmg = 8
	def = 12
	skill = SkillGhoulBite.new()
	passive = PassiveEmpty.new()
	tags = ["ghoul"]
	reroll = 0
