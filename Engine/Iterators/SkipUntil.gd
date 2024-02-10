extends Iterator
class_name SkipUntilIterator

var inner: Iterator
var pattern
var matched: bool

func _init(i, p):
	inner = i
	pattern = p

func next():
	var value = inner.next()
	while !matched && value != null:
		matched = pattern.call(value)
		if !matched:
			value = inner.next()
	return value
