extends Unit
class_name UnitPrincessBhalu

func _init():
	name = "Princess Bhalu"
	texture = load("res://Assets/Units/princess_bhalu.png")
	dmg = 7
	def = 13
	skill = SkillBearsMight.new()
	passive = PassiveEmpty.new()
	tags = ["human", "princess"]
	reroll = 0
