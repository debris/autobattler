extends Log
class_name LogDefBonusAdd

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.def_bonus = max(unit.def_bonus + value, 0)

func _to_string() -> String:
	return unit.name + " gets " + str(value) + " DEF BONUS"
