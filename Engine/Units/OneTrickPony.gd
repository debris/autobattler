extends Unit
class_name UnitOneTrickPony

func _init():
	name = "One Trick Pony"
	texture = load("res://Assets/Units/one_trick_pony.png")
	dmg = 19
	def = 1
	abilities = [
		SkillPonyTrick.new()
	]
	tags = ["horse", "trickster"]
	reroll = 70
