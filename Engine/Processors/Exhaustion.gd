extends Processor
class_name ProcessorExhaustion

const ROUND: int = 1

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	if log.unit.exhausted:
		log.unit.exhausted = false
		var el = LogExhaustion.new(log.unit, battle_state.round - ROUND)
		return [ExecutionEnv.new(log.unit, SkillFromLog.new(el, "Exhaustion", "Exhaustion"))]
	return []
