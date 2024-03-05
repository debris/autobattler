extends Processor
class_name ProcessorPowerOfRenewal

func _process_logs(pl_iterator: ProcessedLogs):
	pl_iterator.iterator()\
		.filter(LogFilters.passive_type(PassivePowerOfRenewal))\
		.filter(LogFilters.type(LogAttack))\
		.for_each(func(pl):
			pl.inner = LogDefend.new(pl.inner.unit, pl.inner.value)
			pl.passive_activated(PassivePowerOfRenewal.new())\
		)
