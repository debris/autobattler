extends Object
class_name MapIterator

var inner
var map_function

func _init(i, m):
	inner = i
	map_function = m

func next():
	var inner_next = inner.next()
	while inner_next != null:
		if map_function.call(inner_next):
			return inner_next
		inner_next = inner.next()
	return null
