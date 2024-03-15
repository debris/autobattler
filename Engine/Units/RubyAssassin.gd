extends Unit
class_name UnitRubyAssassin

func _init():
	name = "Ruby Assassin"
	texture = load("res://Assets/Units/ruby_assassin.png")
	dmg = 16
	def = 4
	abilities = [
		PassiveShadowStrike.new()
	]
	tags = ["assassin"]
	reroll = 0
