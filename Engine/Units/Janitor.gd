extends Unit
class_name UnitJanitor

func _init():
	name = "The Janitor"
	texture = load("res://Assets/Units/janitor.png")
	dmg = 9
	def = 11
	skill = SkillPaint.new(false)
	passive = PassiveEmpty.new()
	tags = []
