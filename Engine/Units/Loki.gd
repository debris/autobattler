extends Unit
class_name UnitLoki

func _init():
	name = "Loki"
	texture = load("res://Assets/Units/loki.png")
	dmg = 13
	def = 7
	abilities = [
		SkillLokiSwap.new()
	]
	tags = ["viking", "trickster", "god"]
	reroll = 50
