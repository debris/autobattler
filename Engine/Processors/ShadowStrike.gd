# Processor for PassiveShadowStrike
extends Processor
class_name ProcessorShadowStrike

var time_of_last_attack_by_unit = {}

func _process_log(log: Log, battle_state: BattleState) -> Array[ExecutionEnv]:
	if log.unit.unit.base.passive is PassiveShadowStrike && log is LogAttack:
		if battle_state.round > 2:
			var last_attack_time = time_of_last_attack_by_unit.get(log.unit.get_instance_id())
			if last_attack_time == null || battle_state.round > last_attack_time + 3:
				log.value *= 3
		time_of_last_attack_by_unit[log.unit.get_instance_id()] = battle_state.round
	return []
