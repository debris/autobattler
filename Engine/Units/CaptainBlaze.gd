extends Unit
class_name UnitCaptainBlaze

func _init():
	name = "Captain Blaze"
	texture = load("res://Assets/Units/captain_blaze.png")
	dmg = 10
	def = 10
	skill = SkillDirectAttack.new()
	passive = PassiveEmpty.new()
	tags = ["cyborg", "commander"]
	reroll = 0
