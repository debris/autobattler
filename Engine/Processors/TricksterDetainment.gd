# Processor for PassiveTricksterDetainment
extends Processor
class_name ProcessorTricksterDetainment

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	if !log is LogDefend:
		if log.unit.tags.has("trickster"):
			var battle_query = BattleQuery.new(log.unit, battle_state)
			var enemy_team = battle_query.get_enemy_team()
			
			var cop_unit = enemy_team.iterator().find(Filters.passive(PassiveTricksterDetainment))
			if cop_unit.is_some():
				var cop_unit_query = BattleQuery.new(cop_unit.get_value(), battle_state)
				if cop_unit_query.is_on_schedule():
					log.valid = false

	return result
