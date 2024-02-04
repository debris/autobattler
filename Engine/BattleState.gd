# Battle State
#
# Skill execution consists of 3 phases
# 
# 0. PREPARE - Skill is being prepared and transformed into a Log
# 1. PROCESS - Process Logs, multiply its values, schedule Skills that should be executed after
# 2. FINALIZE - Apply Log values to the state

extends Resource
class_name BattleState

signal action_executed
signal _internal_proceed

var round: int
var phase: int
var team_a: BattleTeam
var team_b: BattleTeam
var logs: Array[Log]
var processors: Array[Processor]

func _init(a: Team, b: Team):
	round = 0
	phase = 0
	team_a = BattleTeam.new(a)
	team_b = BattleTeam.new(b)
	logs = []
	processors = [
		ProcessorExtraCast.new()
	]

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
					var to_execute: Array[ExecutionEnv] = [ExecutionEnv.new(battle_unit, skill)]
					var executed = 0
					while executed < to_execute.size():
						var env = to_execute[executed]
						# PREPARE
						var logs = env.skill._execute(BattleQuery.new(env.battle_unit, self))
						# PROCESS
						for log in logs:
							for processor in processors:
								var envs = processor._process_log(log, self)
								# TODO: envs should be inserted not appended
								to_execute.append_array(envs)
							# FINALIZE
							# applies changes to the state
							log._finalize(self)
						await _display(env.battle_unit, env.battle_unit.schedule_pointer(phase), logs)
						executed += 1
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
