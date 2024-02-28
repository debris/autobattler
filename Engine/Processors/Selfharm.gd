extends Processor
class_name ProcessorSelfharm

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.my_team_stacks_not_zero(Stacks.Kind.SELFHARM))\
		.for_each(func(pl):
			pl.inner = LogSelfAttack.new(pl.inner.unit, pl.inner.value)
			var new_log = LogStacksAdd.new(pl.get_value().unit, pl.query().get_my_team(), Stacks.Kind.SELFHARM, -1)
			pl.reply_same_move(new_log)\
		)
