extends Processor
class_name ProcessorVigilant

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.enemy_team_stacks_not_zero(Stacks.Kind.VIGILANT))\
		.for_each(func(pl):
			pl.get_value().valid = false
			var new_log = LogStacksAdd.new(pl.get_value().unit, pl.query().get_enemy_team(), Stacks.Kind.VIGILANT, -1)
			pl.reply_same_move(new_log)\
		)
