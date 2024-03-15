extends Unit
class_name UnitDefenceCoach

func _init():
	name = "Defence Coach"
	texture = load("res://Assets/Units/defence_coach.png")
	dmg = 9
	def = 11
	abilities = [
		SkillSubDefence.new()
	]
	tags = ["coach", "human"]
	reroll = 0
