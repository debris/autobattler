extends Iterator
class_name SkipIterator

var inner: Iterator
var max: int
var current: int

func _init(i, m):
	inner = i
	max = m
	current = 0

func next():
	var value = inner.next()
	while current != max && value != null:
		current += 1
		value = inner.next()
	return value
