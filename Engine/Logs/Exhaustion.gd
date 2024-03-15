extends Log
class_name LogExhaustion

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(battle_state: BattleState):
	var battle_query = BattleQuery.new(unit, battle_state)
	var team = battle_query.get_my_team()
	# team might be null if unit got swapped in the same phase he was using the skill
	if team != null:
		team.power -= value
	else:
		valid = false
	

func _to_string() -> String:
	return unit.name + " is exhausted and hurts own team for " + str(value)
	
