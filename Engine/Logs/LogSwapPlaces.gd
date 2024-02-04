extends Log
class_name LogSwapPlaces

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(_battle_state: BattleState):
	unit.swap_with(other_unit)

func _to_string() -> String:
	return unit.unit.base.name + " SWAPPED places with " + other_unit.unit.base.name
