extends Log
class_name LogSwapPlaces

var other_unit: BattleUnit

func _init(u, o):
	unit = u
	other_unit = o

func _finalize(battle_state: BattleState):
	# TODO: change implementation once UI displays data based on slot, not unit
	#var unit_position = BattleQuery.new(unit, battle_state).get_my_position()
	#var other_position = BattleQuery.new(other_unit, battle_state).get_my_position()
#
	#if unit_position != null:
		#unit_position.battle_team.members[unit_position.index] = other_unit
#
	#if other_position != null:
		#other_position.battle_team.members[other_position.index] = unit
	
	unit.swap_with(other_unit)

func _to_string() -> String:
	return unit.name + " SWAPPED with " + other_unit.name
