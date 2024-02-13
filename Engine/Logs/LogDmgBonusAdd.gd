extends Log
class_name LogDmgBonusAdd

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.dmg_bonus = max(unit.dmg_bonus + value, 0)

func _to_string() -> String:
	return unit.name + " gets " + str(value) + " dmg bonus"
