extends Unit
class_name UnitElfArcher

func _init():
	name = "Elf Archer"
	texture = load("res://Assets/Units/elf_archer.png")
	dmg = 12
	def = 8
	abilities = [
		SkillArrowBarrage.new()
	]
	tags = ["elf", "archer"]
	reroll = 0
