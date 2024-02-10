extends Unit
class_name UnitLesserDemon

func _init():
	name = "Lesser Demon"
	texture = load("res://Assets/Units/lesser_demon.png")
	dmg = 10
	def = 10
	skill = SkillCorruption.new()
	passive = PassiveEmpty.new()
	tags = ["demon"]
	reroll = 0
