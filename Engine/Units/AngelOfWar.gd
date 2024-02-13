extends Unit
class_name UnitAngelOfWar

func _init():
	name = "Angel of War"
	texture = load("res://Assets/Units/angel_of_war.png")
	dmg = 12
	def = 8
	skill = SkillEmpty.new()
	passive = PassiveDoubleStrike.new()
	tags = ["demon"]
	reroll = 0
