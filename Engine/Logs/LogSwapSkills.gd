extends Log
class_name LogSwapSkills

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(_battle_state: BattleState):
	var tmp = unit.skill
	unit.skill = other_unit.skill
	other_unit.skill = tmp

func _to_string() -> String:
	return unit.unit.base.name + " SWAPPED skills with " + other_unit.unit.base.name
