# Processor for PassiveAutoHive
extends Processor
class_name ProcessorAutoHive

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	var result: Array[ExecutionEnv] = []
	if log is LogAttack:
		var battle_query = BattleQuery.new(log.unit, battle_state)
		var team = battle_query.get_my_team()
		var enemy_team = battle_query.get_enemy_team()
		if team.power >= 2 * enemy_team.power:
			for battle_unit in enemy_team.members:
				if battle_unit.tags.has("bee") || battle_unit.tags.has("mech"):
					result.push_back(ExecutionEnv.new(battle_unit, SkillAttack.new()))

	return result
