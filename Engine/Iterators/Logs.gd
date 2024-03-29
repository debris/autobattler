extends Iterator
class_name LogsIterator

var inner: Iterator

func _init(logs: Array[Log], filter_unit: BattleUnit = null):
	inner = ArrayIterator.new(logs).filter(func(battle_log):
		return filter_unit == null || (battle_log.unit.get_instance_id() == filter_unit.get_instance_id())
	)

func next():
	return inner.next()
