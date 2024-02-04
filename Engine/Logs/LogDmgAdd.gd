# Increase dmg be certain value
extends Log
class_name LogDmgAdd

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.dmg = max(unit.dmg + value, 0)

func _to_string() -> String:
	return unit.unit.base.name + " ADDs " + str(value) + " DMG"
