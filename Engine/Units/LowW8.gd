extends Unit
class_name UnitLowW8

func _init():
	name = "LOW-W8"
	texture = load("res://Assets/Units/low_w8.png")
	dmg = 8
	def = 12
	skill = SkillAntiHack.new()
	passive = PassiveEmpty.new()
	tags = ["robot", "cyborg"]
	reroll = 0
