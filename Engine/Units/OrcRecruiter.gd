extends Unit
class_name UnitOrcRecruiter

func _init():
	name = "Orc Recruiter"
	texture = load("res://Assets/Units/orc_recruiter.png")
	dmg = 11
	def = 9
	skill = SkillGreenRanks.new()
	passive = PassiveEmpty.new()
	tags = ["orc"]
	reroll = 0
