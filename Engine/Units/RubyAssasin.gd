extends Unit
class_name UnitRubyAssasin

func _init():
	name = "Ruby Assasin"
	texture = load("res://Assets/Units/ruby_assasin.png")
	dmg = 16
	def = 4
	skill = SkillEmpty.new()
