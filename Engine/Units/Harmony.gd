extends Unit
class_name UnitHarmony

func _init():
	name = "Harmony"
	texture = load("res://Assets/Units/harmony.png")
	dmg = 5
	def = 15
	skill = SkillUnionize.new()
	passive = PassiveEmpty.new()
	tags = ["cyborg"]
