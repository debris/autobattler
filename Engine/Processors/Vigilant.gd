extends Processor
class_name ProcessorVigilant

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	if log is LogAttack:
		var battle_query = BattleQuery.new(log.unit, battle_state)
		var enemy_team = battle_query.get_enemy_team()
		if enemy_team.stacks.get_value(Stacks.Kind.VIGILANT) > 0:
			log.valid = false
			var skill = SkillFromLog.new(LogStacksAdd.new(log.unit, enemy_team, Stacks.Kind.VIGILANT, -1), "Missed", "Missed")
			result.push_back(ExecutionEnv.new(log.unit, skill))
	return result
