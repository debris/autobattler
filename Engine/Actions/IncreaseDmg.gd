# Increase dmg by certain amount %
extends Action
class_name ActionIncreaseDmg

var increase: int

func _init(u: BattleUnit, i: int):
	unit = u
	increase = i
