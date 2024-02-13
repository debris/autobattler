# Processor for PassiveTricksterDetainment
extends Processor
class_name ProcessorTricksterDetainment

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.tag("trickster"))\
		.filter(LogFilters.not_type(LogDefend))\
		.for_each(func(pl): 
			var cop_unit = pl.query().get_enemy_team().iterator().find(Filters.passive(PassiveTricksterDetainment))
			if cop_unit.is_some():
				var cop_unit_query = BattleQuery.new(cop_unit.get_value(), pl.query().battle_state)
				if cop_unit_query.is_on_schedule():
					pl.passive_activated(PassiveTricksterDetainment.new())
					pl.get_value().valid = false\
		)
