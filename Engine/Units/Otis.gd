extends Unit
class_name UnitOtis

func _init():
	name = "Otis"
	texture = load("res://Assets/Units/otis.png")
	dmg = 6
	def = 14
	abilities = [
		SkillSelfishExchange.new()
	]
	tags = ["god"]
	reroll = 70
