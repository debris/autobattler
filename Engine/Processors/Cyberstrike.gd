# Processor for PassiveDoublestrike
extends Processor
class_name ProcessorCyberstrike

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.tag("assassin"))\
		.for_each(func(pl):
			pl.query().get_my_team().iterator()\
				.filter(Filters.passive(PassiveCyberstrike))\
				.filter(Filters.not_this_unit(pl.get_unit()))\
				.for_each(func(unit):
					pl.passive_activated(PassiveCyberstrike.new())
					pl.reply_next_exe(ExecutionEnv.new(unit, SkillAttack.new()))\
				)\
		)
	
