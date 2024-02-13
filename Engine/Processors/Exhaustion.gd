extends Processor
class_name ProcessorExhaustion

const ROUND: int = 1

var time_of_last_move_by_unit = {}

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.round_greater_than(ROUND))\
		.filter(LogFilters.is_on_schedule)\
		.for_each(func(pl):
			var query = pl.query()
			var value = pl.get_value()
			var last_move_time = time_of_last_move_by_unit.get(value.unit.get_instance_id())
			if last_move_time == null || query.get_round() > last_move_time:
				var el = LogExhaustion.new(value.unit, query.get_round() - ROUND)
				pl.reply_next_move(el)
			time_of_last_move_by_unit[value.unit.get_instance_id()] = query.get_round()\
		)
