extends Unit
class_name UnitVikingWarrior

func _init():
	name = "Viking Warrior"
	texture = load("res://Assets/Units/viking_warrior.png")
	dmg = 10
	def = 10
	skill = Skill.new()
