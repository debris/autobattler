extends Unit
class_name UnitDefenceCoach

func _init():
	name = "Defence Coach"
	texture = load("res://Assets/Units/defence_coach.png")
	dmg = 9
	def = 11
	skill = SkillSubDefence.new()
	passive = PassiveEmpty.new()
	tags = ["coach"]
	reroll = 0
