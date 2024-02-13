# Processor for PassiveDoubleStrike
extends Processor
class_name ProcessorDoubleStrike

var duplicated_logs_by_unit = {}

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.passive_type(PassiveDoubleStrike))\
		.for_each(func(pl):
			var dup = duplicated_logs_by_unit.get(pl.get_unit().get_instance_id())
			if dup == null || (dup != pl.get_value().get_instance_id()):
				pl.passive_activated(PassiveDoubleStrike.new())
				var half = pl.get_value().value / 2
				pl.get_value().value = half
				var skill = SkillFromLog.new(pl.get_value(), "", "")
				pl.reply_next_exe(ExecutionEnv.new(pl.get_unit(), skill))
				# works only cause we pass the same log there
				# TODO: insert copy of the log
				duplicated_logs_by_unit[pl.get_unit().get_instance_id()] = pl.get_value().get_instance_id()\
		)
	
