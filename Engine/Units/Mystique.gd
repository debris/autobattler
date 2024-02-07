extends Unit
class_name UnitMystique

func _init():
	name = "Mystique"
	texture = load("res://Assets/Units/mystique.png")
	dmg = 10
	def = 10
	skill = SkillShapeshift.new()
	passive = PassiveEmpty.new()
	tags = ["elf", "druid"]
	# TODO, extra casts dont work properly
