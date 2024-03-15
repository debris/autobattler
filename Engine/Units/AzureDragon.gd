extends Unit
class_name UnitAzureDragon

func _init():
	name = "Azure Dragon"
	texture = load("res://Assets/Units/azure_dragon.png")
	dmg = 9
	def = 11
	abilities = [
		SkillAzureMomentum.new()
	]
	tags = ["dragon"]
	reroll = 0
