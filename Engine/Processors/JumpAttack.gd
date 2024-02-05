# Processor for PassiveJumpAttack
extends Processor
class_name ProcessorJumpAttack

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	
	var passive = log.unit.unit.base.passive
	if log is LogAttack && passive is PassiveJumpAttack:
		var battle_query = BattleQuery.new(log.unit, battle_state)
		var unit_to_swap = battle_query.get_next_unit()
		
		if unit_to_swap == null:
			log.valid = false
			unit_to_swap = battle_query.get_first_unit()
			
		var skill = SkillFromLog.new(LogSwapPlaces.new(log.unit, unit_to_swap), passive.name, passive.description)
		result.push_back(ExecutionEnv.new(log.unit, skill))

	return result
