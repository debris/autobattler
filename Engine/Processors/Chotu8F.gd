extends Processor
class_name ProcessorChotu8F

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogSkillUsed))\
		.filter(LogFilters.my_team_avatar(AvatarChotu8F))\
		.for_each(func(pl):
			var battle_unit = pl.get_unit()
			var my_team = pl.query().get_my_team()
			var add_power = max(1, battle_unit.def * 10 / 100)
			var new_log = LogPower.new(battle_unit, my_team, add_power)
			pl.avatar_passive_activated(my_team.avatar)
			pl.reply_next_move(new_log)\
		)
