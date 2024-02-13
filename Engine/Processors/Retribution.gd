extends Processor
class_name ProcessorRetribution

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.for_each(func(pl):
			var opposite = pl.query().get_opposite_unit().filter(Filters.passive(PassiveRetribution)).first()
			if opposite.is_some():
				var op = opposite.get_value()
				var skill = SkillAttack.new()
				pl.passive_activated(PassiveRetribution.new())
				pl.reply_next_exe(ExecutionEnv.new(op, skill))\
		)
