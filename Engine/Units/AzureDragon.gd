extends Unit
class_name UnitAzureDragon

func _init():
	name = "Azure Dragon"
	texture = load("res://Assets/Units/azure_dragon.png")
	dmg = 9
	def = 11
	skill = SkillAzureMomentum.new()
	passive = PassiveEmpty.new()
	tags = ["dragon"]
	# TODO, extra casts dont work properly
