extends Unit
class_name UnitTimeTraveller

func _init():
	name = "Time Traveller"
	texture = load("res://Assets/Units/time_traveller.png")
	dmg = 10
	def = 10
	skill = SkillTimeTravel.new()
	passive = PassiveEmpty.new()
	tags = []
