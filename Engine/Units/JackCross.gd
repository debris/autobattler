extends Unit
class_name UnitJackCross

func _init():
	name = "Jack Cross"
	texture = load("res://Assets/Units/jack_cross.png")
	dmg = 13
	def = 7
	skill = SkillDoubleCross.new()
	passive = PassiveEmpty.new()
	tags = ["trickster"]
	# TODO, extra casts dont work properly
