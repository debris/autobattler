extends Processor
class_name ProcessorSuicideAttempt

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.passive_type(PassiveSuicideAttempt))\
		.filter(LogFilters.any_type([LogAttack, LogDefend]))\
		.for_each(func(pl):
			var query = pl.query()	
			var unit = query.get_this_unit()
			
			var attack = LogAttack.new(unit, unit.dmg)
			var self_attack = LogSelfAttack.new(unit, unit.dmg)

			pl.passive_activated(PassiveSuicideAttempt.new())
			pl.reply_next_move(attack)
			pl.reply_next_move(self_attack)\
		)
