# Increase dmg be certain value
extends Log
class_name LogDmgAdd

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v
