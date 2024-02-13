# Increase def by certain value
extends Log
class_name LogDefAdd

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.def = max(unit.def + value, 0)

func _to_string() -> String:
	return unit.name + " gets " + str(value) + " def"
