extends Log
class_name LogSwapPlaces

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(battle_state: BattleState):
	var unit_position = BattleQuery.new(unit, battle_state).get_my_position()
	var other_position = BattleQuery.new(other_unit, battle_state).get_my_position()

	assert(unit_position != null, "use `LogTurnInto` instead")
	unit_position.battle_team.members[unit_position.index] = other_unit

	assert(other_position != null, "use `LogTurnInto` instead")
	other_position.battle_team.members[other_position.index] = unit

func _to_string() -> String:
	return unit.name + " SWAPPED with " + other_unit.name
