extends Unit
class_name UnitOtis

func _init():
	name = "Otis"
	texture = load("res://Assets/Units/otis.png")
	dmg = 6
	def = 14
	skill = SkillSelfishExchange.new()
	passive = PassiveEmpty.new()
	tags = ["god"]
	reroll = 70
