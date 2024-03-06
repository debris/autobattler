extends Log
class_name LogSwapStats

func _init(u: BattleUnit):
	unit = u

func _finalize(_battle_state: BattleState):
	var tmp = unit.dmg
	unit.dmg= unit.def
	unit.def = tmp

func _to_string() -> String:
	return unit.name + " swapped damage and defense."
