# Increase dmg be certain value
extends Log
class_name LogSetSchedules

var schedules: Array[Schedule]

func _init(u: BattleUnit, s: Array[Schedule]):
	unit = u
	schedules = s

func _finalize(_battle_state: BattleState):
	unit.schedules = schedules

func _to_string() -> String:
	return unit.name + " has new schedules"
