extends Unit
class_name UnitNova

func _init():
	name = "Nova"
	texture = load("res://Assets/Units/nova.png")
	dmg = 8
	def = 12
	abilities = [
		PassivePowerOfRenewal.new()
	]
	tags = ["god"]
	reroll = 40