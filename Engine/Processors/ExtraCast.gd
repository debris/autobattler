extends Processor
class_name ProcessorExtraCast

func _process_log(log: Log, _battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	if log is LogSkillUsed:
		var bonus_casts = log.unit.skill_bonus_casts
		for i in bonus_casts:
			result.push_back(ExecutionEnv.new(log.unit, log.skill))
			log.unit.skill_bonus_casts -= 1
	return result
