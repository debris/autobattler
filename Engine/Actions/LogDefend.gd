extends Log
class_name LogDefend

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v
