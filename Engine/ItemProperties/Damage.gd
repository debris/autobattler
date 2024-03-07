extends ItemProperty
class_name ItemPropertyDamage

@export var value: int

func _init():
	property_name = "Increased Damage"
	reroll = 0

func _create_for_tier_and_seed(tier: int, s: int):
	var data = ItemPropertyDamage.new()
	data.value = s % (tier * 10 + 1)
	return data
