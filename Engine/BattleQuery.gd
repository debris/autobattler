# Allows battle unit to query different nodes on the battlefield
extends Resource
class_name BattleQuery

var root: BattleUnit
var battle_state: BattleState

func _init(r, s):
	root = r
	battle_state = s

func get_this_unit() -> BattleUnit:
	return root

func get_round() -> int:
	return battle_state.round

# returns all units from team a and team b
func get_all_units() -> Array[BattleUnit]:
	var all = []
	all.append_array(battle_state.team_a.members)
	all.append_array(battle_state.team_b.members)
	return all

func get_my_team() -> BattleTeam:
	var position = get_my_position()
	return position.battle_team

# returns position in a team
func get_my_position() -> BattleUnitPosition:
	var position_in_team = func(team):
		for i in team.members.size():
			var member = team.members[i]
			if member != null && member.get_instance_id() == root.get_instance_id():
				return BattleUnitPosition.new(team, i)
		
	var position = position_in_team.call(battle_state.team_a)
	if position != null:
		return position
	return position_in_team.call(battle_state.team_b)

# returns unit on the right hand side or null if there is none
# or we are the rightmost unit
func get_next_unit() -> BattleUnit:
	var position = get_my_position()
	if position.is_last():
		return null

	# may also be null
	return position.battle_team.members[position.index + 1]

func get_logs(skip: int = 0) -> Array[Log]:
	var result: Array[Log] = []
	for i in battle_state.logs.size() - skip:
		var index_to_check = i + skip
		var log_to_check = battle_state.logs[index_to_check]
		if log_to_check.unit.get_instance_id() == root.get_instance_id():
			result.push_back(log_to_check)
	return result

func get_total_log_count() -> int:
	return battle_state.logs.size()
