extends ArrayIterator
class_name FilterIterator

var inner
var filter_function

func _init(i, m):
	inner = i
	filter_function = m

func next():
	var inner_next = inner.next()
	while inner_next != null:
		if filter_function.call(inner_next):
			return inner_next
		inner_next = inner.next()
	return null
