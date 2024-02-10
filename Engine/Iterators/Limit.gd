extends Iterator
class_name LimitIterator

var inner: Iterator
var end: int
var current: int

func _init(i, l):
	inner = i
	end = l
	current = 0

func next():
	if current == end:
		return null
	
	var inner_next = inner.next()
	current += 1
	return inner_next
