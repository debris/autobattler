extends Unit
class_name UnitTinten

func _init():
	name = "Tinten"
	texture = load("res://Assets/Units/tinten.png")
	dmg = 9
	def = 11
	skill = SkillPaint.new()
	passive = PassiveEmpty.new()
	tags = ["water"]
