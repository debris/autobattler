extends Unit
class_name UnitOfficerJoe

func _init():
	name = "Officer Joe"
	texture = load("res://Assets/Units/officer_joe.png")
	dmg = 12
	def = 8
	abilities = [
		PassiveTricksterDetainment. new()
	]
	tags = ["police", "officer"]
	reroll = 0
