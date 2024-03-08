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

var pointer: BattleStatePointer
var team_a: BattleTeam
var team_b: BattleTeam
var processors: Array[Processor]
var logs: Array[Log]

func _init(a: BattleTeam, b: BattleTeam):
	pointer = BattleStatePointer.new()
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
		ProcessorCyberstrike.new(),
		ProcessorScheduledSkills.new(),
		ProcessorSuicideAttempt.new(),
		ProcessorPowerOfRenewal.new(),
		ProcessorChotu8F.new(),
		ProcessorPoison.new(),
		ProcessorSelfharm.new(),
		ProcessorExhaustion.new(),
	]

func team_a_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_a, self)

func team_b_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_b, self)

func _battle_unit_at(battle_state_pointer: BattleStatePointer) -> BattleUnit:
	if battle_state_pointer.unit_index % 2 == 0:
		return team_a.members[battle_state_pointer.unit_index / 2]
	else:
		return team_b.members[battle_state_pointer.unit_index / 2]

func execute_step():
	var battle_unit = _battle_unit_at(pointer)
	
	if battle_unit != null:
		if battle_unit.schedules[pointer.battle_phase].at(pointer.battle_round):
			
			var skill = battle_unit.skill_at(pointer.battle_phase)
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
	
	# at the end of the step move pointers
	pointer.advance()

func execute_game():
	while true:
		await execute_step()

func proceed():
	_internal_proceed.emit()

# private
func _display(battle_unit, actions):
	battle_unit.schedule_pointer.active = true
	battle_unit.schedule_pointer.battle_round = pointer.battle_round
	battle_unit.schedule_pointer.phase = pointer.battle_phase

	logs.append_array(actions)
	
	action_executed.emit()
	await _internal_proceed
	battle_unit.schedule_pointer.active = false
	# point at the next battle_round (?)
	#battle_unit.schedule_pointer.battle_round += 1

func _display_none(schedule_pointer):
	schedule_pointer.active = true
	schedule_pointer.battle_round = pointer.battle_round
	schedule_pointer.phase = pointer.battle_phase
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next battle_round (?)
	#schedule_pointer.battle_round += 1

func queue() -> Array[QueuePosition]:
	const QUEUE_MIN_SIZE: int = 7
	var new_queue: Array[QueuePosition] = []
	var virtual_pointer = pointer.copy()

	while new_queue.size() < QUEUE_MIN_SIZE:
		var battle_unit = _battle_unit_at(virtual_pointer)
		if battle_unit != null:
			var schedule = battle_unit.schedules[virtual_pointer.battle_phase]
			if schedule.at(virtual_pointer.battle_round):
				new_queue.push_back(QueuePosition.new(battle_unit, virtual_pointer.battle_round, virtual_pointer.battle_phase, schedule.kind))
		virtual_pointer.advance()
	
	return new_queue