extends Log
class_name LogSwapSkills

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(_battle_state: BattleState):
	var tmp = unit.abilities
	unit.abilities = other_unit.abilities
	other_unit.abilities = tmp

func _to_string() -> String:
	return unit.name + " swaps skills with " + other_unit.name
