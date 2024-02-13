extends Processor
class_name ProcessorScheduledSkills

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogSkillScheduled))\
		.for_each(func(pl):
			var value = pl.get_value()
			pl.reply_next_exe(ExecutionEnv.new(value.unit, value.skill))\
		)
