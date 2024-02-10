extends Unit
class_name UnitBeeNinja

func _init():
	name = "Bee Ninja"
	texture = load("res://Assets/Units/bee_ninja.png")
	dmg = 12
	def = 8
	skill = SkillEmpty.new()
	passive = PassiveJumpAttack.new()
	tags = ["bee", "assassin"]
	reroll = 0
