extends Processor
class_name ProcessorPoison

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.any_type([LogAttack, LogDefend, LogSkillUsed]))\
		.filter(LogFilters.my_team_stacks_not_zero(Stacks.Kind.POISON))\
		.for_each(func(pl):
			var poison_stacks = pl.query().get_my_team().stacks.get_value(Stacks.Kind.POISON)
			var poison_value = max(1, poison_stacks * pl.get_unit().def * 10 / 100)
			var skill = SkillFromLog.new(LogPoison.new(pl.get_unit(), poison_value), "", "")
			pl.reply_next_exe(ExecutionEnv.new(pl.get_unit(), skill))
			var new_log = LogStacksAdd.new(pl.get_unit(), pl.query().get_my_team(), Stacks.Kind.POISON, -1)
			pl.reply_same_move(new_log)\
		)
