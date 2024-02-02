# Increase dmg by certain amount %
extends Action
class_name ActionIncreaseDmg

var unit: BattleUnit
var increase: int

func _init(u: BattleUnit, i: int):
	unit = u
	increase = i

func _execute():
	unit.dmg += unit.dmg * increase / 100
