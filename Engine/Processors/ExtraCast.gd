extends Processor
class_name ProcessorExtraCast

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogSkillUsed))\
		.for_each(func(pl):
			var bonus_casts = pl.get_value().unit.skill_bonus_casts
			if bonus_casts > 0:
				pl.reply_same_move(LogSkillCastBonus.new(pl.get_unit(), -1))
				pl.reply_next_exe(ExecutionEnv.new(pl.get_unit(), pl.get_skill()))\
		)
		
