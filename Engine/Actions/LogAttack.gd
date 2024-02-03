extends Log
class_name LogAttack

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v
