# Processor for PassiveShadowStrike
extends Processor
class_name ProcessorShadowStrike

var time_of_last_attack_by_unit = {}

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.passive_type(PassiveShadowStrike))\
		.for_each(func(pl):
			if pl.query().get_round() > 2:
				var last_attack_time = time_of_last_attack_by_unit.get(pl.get_value().unit.get_instance_id())
				if last_attack_time == null || pl.query().get_round() > last_attack_time + 3:
					pl.get_value().value *= 3
			time_of_last_attack_by_unit[pl.get_value().unit.get_instance_id()] = pl.query().get_round()\
		)
