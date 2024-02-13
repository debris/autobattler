extends Resource
class_name ExecutionChanges

var execution_logs: Array[Log]
var depth: int

func _init(el: Array[Log], d = 0):
	execution_logs = el
	depth = d
