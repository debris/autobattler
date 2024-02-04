extends Unit
class_name UnitOrcWarrior

func _init():
	name = "Orc Warrior"
	texture = load("res://Assets/Units/orc_warrior.png")
	dmg = 10
	def = 10
	skill = SkillBloodRage.new()
	passive = PassiveEmpty.new()
	tags = ["orc", "warrior"]
