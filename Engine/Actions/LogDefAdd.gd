# Increase def by certain value
extends Log
class_name LogDefAdd

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v
