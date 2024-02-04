# Processor for PassiveTricksterDetainment
extends Processor
class_name ProcessorTricksterDetainment

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	if !log is LogDefend:
		if log.unit.tags.has("trickster"):
			var battle_query = BattleQuery.new(log.unit, battle_state)
			var enemy_team = battle_query.get_enemy_team()
			for battle_unit in enemy_team.members:
				if battle_unit.unit.base.passive is PassiveTricksterDetainment:
					var cop_unit_query = BattleQuery.new(battle_unit, battle_state)
					if cop_unit_query.is_on_schedule():
						log.valid = false

	return result