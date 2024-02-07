# Allows battle unit to query different nodes on the battlefield
extends Query
class_name BattleQuery

var root: BattleUnit
var battle_state: BattleState

func _init(r: BattleUnit, s: BattleState):
	root = r
	battle_state = s

func with_root(r) -> BattleQuery:
	return BattleQuery.new(r, battle_state)

func get_this_unit() -> BattleUnit:
	return root

func get_round() -> int:
	return battle_state.round

func get_phase() -> int:
	return battle_state.phase
#
func is_active() -> bool:
	return root.schedule_pointer.active

# returns true if unit is on schedule this round and phase
func is_on_schedule(round = battle_state.round, phase = battle_state.phase) -> bool:
	return root.schedules[phase].at(round)

# returns all units from team a and team b
func get_all_units() -> Array[BattleUnit]:
	var all: Array[BattleUnit] = []
	all.append_array(battle_state.team_a.members)
	all.append_array(battle_state.team_b.members)
	return all

func get_my_team() -> BattleTeam:
	var position = get_my_position()
	return position.battle_team

func get_enemy_team() -> BattleTeam:
	var position = get_my_position()
	if position.battle_team.get_instance_id() == battle_state.team_a.get_instance_id():
		return battle_state.team_b
	return battle_state.team_a

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

func get_opposite_unit() -> BattleUnit:
	var position = get_my_position()
	var enemy_team = get_enemy_team()
	if position.index >= enemy_team.members.size():
		return null
	return enemy_team.members[position.index]

# returns unit on the right hand side or null if there is none
# or we are the rightmost unit
func get_next_unit() -> BattleUnit:
	var position = get_my_position()
	if position.is_last():
		return null

	# may also be null
	return position.battle_team.members[position.index + 1]

func get_prev_unit() -> BattleUnit:
	var position = get_my_position()
	if position.index == 0:
		return null
	
	return position.battle_team.members[position.index - 1]

func get_first_unit() -> BattleUnit:
	var team = get_my_team()
	return team.members[0]

func get_logs_iterator() -> LogsIterator:
	return LogsIterator.new(battle_state, root)
