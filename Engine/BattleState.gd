extends Resource
class_name BattleState

signal action_executed
signal _internal_proceed

var round: int
var phase: int
var team_a: BattleTeam
var team_b: BattleTeam
var logs: Array[Log]

func _init(a: Team, b: Team):
	round = 0
	phase = 0
	team_a = BattleTeam.new(a)
	team_b = BattleTeam.new(b)

func team_a_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_a, self)

func team_b_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_b, self)

func execute_round():
	assert(team_a.members.size() == team_b.members.size())
	var size = team_a.members.size()
	var phases = 3
	for p in phases:
		phase = p
		for i in size:
			var run_skill_for_team = func(team):
				var battle_unit = team.members[i]
				if battle_unit.schedule(phase).at(round):
					var skill = battle_unit.skill(phase)
					var logs = skill._execute(BattleQuery.new(battle_unit, self))
					await _display(battle_unit, battle_unit.schedule_pointer(phase), logs)
				else:
					await _display_none(battle_unit.schedule_pointer(phase))
			
			await run_skill_for_team.call(team_a)
			await run_skill_for_team.call(team_b)

	phase = 0
	round += 1

func proceed():
	_internal_proceed.emit()

# private
func _display(battle_unit, schedule_pointer, actions):
	schedule_pointer.active = true
	schedule_pointer.round = round
	
	print_debug("actions: ", actions)
	logs.append_array(actions)
	
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next round
	schedule_pointer.round += 1

func _display_none(schedule_pointer):
	schedule_pointer.active = true
	schedule_pointer.round = round
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next round
	schedule_pointer.round += 1
