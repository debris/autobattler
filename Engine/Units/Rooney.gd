extends Unit
class_name UnitRooney

func _init():
	name = "Rooney"
	texture = load("res://Assets/Units/rooney.png")
	dmg = 10
	def = 10	
	skill = SkillDirtyLaugh.new()
	passive = PassiveEmpty.new()
	tags = ["trickster"]
	reroll = 0
