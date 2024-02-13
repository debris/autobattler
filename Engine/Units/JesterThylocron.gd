extends Unit
class_name UnitJesterThylocron

func _init():
	# Jester was too long
	#name = "Jester Thylocron"
	name = "Thylocron"
	texture = load("res://Assets/Units/jester_thylocron.png")
	dmg = 11
	def = 9
	skill = SkillMimicry.new()
	passive = PassiveEmpty.new()
	tags = ["trickster"]
	reroll = 0
