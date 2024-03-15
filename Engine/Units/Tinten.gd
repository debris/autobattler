extends Unit
class_name UnitTinten

func _init():
	name = "Tinten"
	texture = load("res://Assets/Units/tinten.png")
	dmg = 9
	def = 11
	abilities = [
		SkillPaint.new(true)
	]
	tags = ["water"]
	reroll = 50
