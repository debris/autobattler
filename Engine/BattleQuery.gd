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
	return battle_state.pointer.battle_round

func get_phase() -> int:
	return battle_state.pointer.battle_phase

func is_active() -> bool:
	return root.schedule_pointer.active

# returns true if unit is on schedule this round and phase
func is_on_schedule(r = battle_state.battle_round, phase = battle_state.phase) -> bool:
	return root.schedules[phase].at(r)

# returns all units from team a and team b
func get_all_units() -> Iterator:
	return battle_state.team_a.iterator().concat(battle_state.team_b.iterator())

func get_my_team() -> BattleTeam:
	var maybe_a = battle_state.team_a.iterator()\
		.find(Filters.this_unit(root))\
		.map(func(_v): return battle_state.team_a)\
		.unwrap_or(null)
	
	if maybe_a != null:
		return maybe_a

	return battle_state.team_b.iterator()\
		.find(Filters.this_unit(root))\
		.map(func(_v): return battle_state.team_b)\
		.unwrap_or(null)

func get_enemy_team() -> BattleTeam:
	var my_team = get_my_team()
	if my_team == null:
		return null
	
	if my_team.get_instance_id() == battle_state.team_a.get_instance_id():
		return battle_state.team_b
	
	return battle_state.team_a

# returns position in a team
func get_my_position() -> BattleUnitPosition:
	var team = get_my_team()
	if team == null:
		return null
	var index = team.iterator().until(Filters.this_unit(root)).count()
	return BattleUnitPosition.new(team, index)

func get_opposite_unit() -> Option:
	var position = get_my_position()
	var enemy_team = get_enemy_team()
	return Option.new(enemy_team.members[position.index])

func get_next_units() -> Iterator:
	return get_my_team().iterator()\
		.skip_until(Filters.this_unit(root))\
		.skip(1)

func get_prev_units() -> Iterator:
	var position = get_my_position()
	var reverse_slice = position.battle_team.members.slice(position.index, -position.battle_team.members.size() - 1, -1)
	return ArrayIterator.new(reverse_slice).skip(1)

func get_logs_iterator() -> LogsIterator:
	return LogsIterator.new(battle_state.logs, root)

func get_all_logs_iterator() -> LogsIterator:
	return LogsIterator.new(battle_state.logs)

func get_reverse_logs_iterator() -> LogsIterator:
	var logs = battle_state.logs.slice(battle_state.logs.size() - 1, -battle_state.logs.size() - 1, -1)
	return LogsIterator.new(logs, root)

func get_reverse_all_logs_iterator() -> LogsIterator:
	var logs = battle_state.logs.slice(battle_state.logs.size() - 1, -battle_state.logs.size() - 1, -1)
	return LogsIterator.new(logs)
