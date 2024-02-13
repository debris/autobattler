# Processor for PassiveJumpAttack
extends Processor
class_name ProcessorJumpAttack

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.type(LogAttack))\
		.filter(LogFilters.passive_type(PassiveJumpAttack))\
		.for_each(func(pl):
			var unit_to_swap = pl.query().get_next_units().first()
			if unit_to_swap.is_null():
				pl.get_value().valid = false
				unit_to_swap = pl.query().get_my_team().iterator().first()
			
			var new_log = LogSwapPlaces.new(pl.get_value().unit, unit_to_swap.get_value())
			pl.passive_activated(PassiveJumpAttack.new())
			pl.reply_next_move(new_log)\
		)
