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
var processors: Array[Processor]
var logs: Array[Log]

func _init(a: BattleTeam, b: BattleTeam):
	round = 0
	phase = 0
	team_a = a
	team_b = b
	logs = []
	processors = [
		ProcessorExtraCast.new(),
		ProcessorShadowStrike.new(),
		ProcessorAutoHive.new(),
		ProcessorTricksterDetainment.new(),
		ProcessorJumpAttack.new(),
		ProcessorVigilant.new(),
		ProcessorDoubleStrike.new(),
		ProcessorRetribution.new(),
		ProcessorScheduledSkills.new(),
		ProcessorPoison.new(),
		ProcessorExhaustion.new(),
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
					
					while executed < to_execute.size():
						var env = to_execute[executed]
						# PREPARE
						var changes = env.execute(self)
						# PROCESS
						for processor in processors:
							var more_exes = processor._process_changes(changes, self)
							to_execute.append_array(more_exes)
						# FINALIZE
						for log_to_process in changes.execution_logs:
							if log_to_process.valid:
								log_to_process._finalize(self)
						
						await _display(env.battle_unit, changes.execution_logs)
						executed += 1
				else:
					pass
			
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
