extends Log
class_name LogShapeshift

var other_unit: BattleUnit

func _init(u: BattleUnit, o: BattleUnit):
	unit = u
	other_unit = o

func _finalize(_battle_state: BattleState):
	unit.dmg = other_unit.dmg
	unit.def = other_unit.def
	unit.texture = other_unit.texture

func _to_string() -> String:
	return unit.unit.base.name + " SHAPESHIFTED into " + str(unit.unit.base.name)
