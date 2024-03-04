extends Object
class_name BattleStatePointer

# current battle round, range [0, ~]
var battle_round: int
# current battle phase, range [0, 2]
var battle_phase: int
# index of the next that performs an action, range [0, 11]
# even numbers are units from team_a
# odd numbers are units from team_b
var unit_index: int

func _init():
	battle_round = 0
	battle_phase = 0
	unit_index = 0

func copy() -> BattleStatePointer:
	var result = BattleStatePointer.new()
	result.battle_round = battle_round
	result.battle_phase = battle_phase
	result.unit_index = unit_index
	return result

func advance():
	if unit_index == 11:
		unit_index = 0
		if battle_phase == 2:
			battle_phase = 0
			battle_round += 1
		else:
			battle_phase += 1
	else:
		unit_index += 1
