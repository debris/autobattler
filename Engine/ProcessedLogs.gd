extends Resource
class_name ProcessedLogs

var inner: Array[ProcessedLog]

func _init(logs: Array[Log], bs: BattleState):
	inner.assign(logs.map(func(l): return ProcessedLog.new(l, bs)))

func iterator() -> Iterator:
	return ArrayIterator.new(inner)
