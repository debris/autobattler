# Increase dmg by certain amount %
extends Log
class_name LogDmgAdd

var increase: int

func _init(u: BattleUnit, i: int):
	unit = u
	increase = i
