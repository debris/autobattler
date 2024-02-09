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
		ProcessorExtraCast.new(),
		ProcessorShadowStrike.new(),
		ProcessorAutoHive.new(),
		ProcessorTricksterDetainment.new(),
		ProcessorJumpAttack.new(),
		ProcessorExhaustion.new()
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
				if battle_unit == null:
					return
				if battle_unit.schedules[phase].at(round):
					var skill = battle_unit.skill_at(phase)
					var to_execute: Array[ExecutionEnv] = [ExecutionEnv.new(battle_unit, skill)]
					var executed = 0
					
					# units should start getting exhaused at some point
					if round > ProcessorExhaustion.ROUND:
						battle_unit.exhausted = true
					
					while executed < to_execute.size():
						var env = to_execute[executed]
						# PREPARE
						var logs_to_process = env.skill._execute(BattleQuery.new(env.battle_unit, self))
						# PROCESS
						for log_to_process in logs_to_process:
							for processor in processors:
								var envs = processor._process_log(log_to_process, self)
								# TODO: optimize insertions?
								# also check if its ok that actions from the last processor are
								# inserted first
								# its probably ok, but better check
								for e in envs.size():
									var new_env = envs[e]
									to_execute.insert(executed + 1 + e, new_env)
							# FINALIZE
							# applies changes to the state
							if log_to_process.valid:
								log_to_process._finalize(self)

						await _display(env.battle_unit, logs_to_process)
						executed += 1
				else:
					pass
					#await _display_none(battle_unit.schedule_pointer)
			
			await run_skill_for_team.call(team_a)
			await run_skill_for_team.call(team_b)

	phase = 0
	round += 1

func proceed():
	_internal_proceed.emit()

# private
func _display(battle_unit, actions):
	battle_unit.schedule_pointer.active = true
	battle_unit.schedule_pointer.round = round
	battle_unit.schedule_pointer.phase = phase

	logs.append_array(actions)
	
	action_executed.emit()
	await _internal_proceed
	battle_unit.schedule_pointer.active = false
	# point at the next round (?)
	#battle_unit.schedule_pointer.round += 1

func _display_none(schedule_pointer):
	schedule_pointer.active = true
	schedule_pointer.round = round
	schedule_pointer.phase = phase
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next round (?)
	#schedule_pointer.round += 1
