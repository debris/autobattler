extends Processor
class_name ProcessorSuicideAttempt

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.passive_type(PassiveSuicideAttempt))\
		.filter(LogFilters.any_type([LogAttack, LogDefend]))\
		.for_each(func(pl):
			var query = pl.query()	
			var my_team = query.get_my_team()
			var enemy_team = query.get_enemy_team()
			var unit = query.get_this_unit()
			
			var attack = LogPower.new(unit, my_team, -unit.dmg)
			var attack2 = LogPower.new(unit, enemy_team, -unit.dmg)

			pl.passive_activated(PassiveSuicideAttempt.new())
			pl.reply_next_move(attack)
			pl.reply_next_move(attack2)\
		)
