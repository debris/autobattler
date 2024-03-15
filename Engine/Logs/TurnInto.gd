# should be used to swap with units from outside of battlefield
extends Log
class_name LogTurnInto

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(_battle_state: BattleState):
	unit.turn_into(other_unit)

func _to_string() -> String:
	return unit.name + " swapped with " + other_unit.name
