# Processor for PassiveAutoHive
extends Processor
class_name ProcessorAutoHive

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(func(pl): 
			var team = pl.query().get_my_team()
			var enemy_team = pl.query().get_enemy_team()
			return team.power >= 2 * enemy_team.power\
		)\
		.filter(func(pl):
			var enemy_team = pl.query().get_enemy_team()
			return enemy_team.iterator().filter(Filters.passive(PassiveAutoHive)).first().is_some()\
		).for_each(func(pl):
			var enemy_team = pl.query().get_enemy_team()
			enemy_team.iterator().filter(Filters.any_tag(["bee", "mech"])).for_each(func(battle_unit):
				pl.reply_next_move(LogPassiveActivated.new(battle_unit, PassiveAutoHive.new()))
				pl.reply_next_exe(ExecutionEnv.new(battle_unit, SkillAttack.new()))
			)\
		)
