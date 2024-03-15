extends Unit
class_name UnitHornedOwl

func _init():
	name = "Horned Owl"
	texture = load("res://Assets/Units/horned_owl.png")
	dmg = 10
	def = 10
	abilities = [
		SkillEclipseSentinel.new()
	]
	tags = ["owl"]
	reroll = 0
