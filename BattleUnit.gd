# Unit type that exists only during battles
# keeps temporarily state of the owned unit
extends Resource
class_name BattleUnit

var unit: OwnedUnit
var dmg: int
var def: int

func _init(u: OwnedUnit):
	unit = u
	dmg = u.dmg
	def = u.def
