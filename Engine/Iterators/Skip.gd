extends Iterator
class_name SkipIterator

var inner: Iterator
var end: int
var current: int

func _init(i, m):
	inner = i
	end = m
	current = 0

func next():
	var value = inner.next()
	while current != end && value != null:
		current += 1
		value = inner.next()
	return value
