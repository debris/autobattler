extends ArrayIterator
class_name LimitIterator

var inner
var max: int
var current: int

func _init(i, l):
	inner = i
	max = l
	current = 0

func next():
	if current == max:
		return null
	
	var inner_next = inner.next()
	current += 1
	return inner_next
