extends Iterator
class_name UntilIterator

var inner: Iterator
var pattern
var matched: bool

func _init(i, p):
	inner = i
	pattern = p
	matched = false

func next():
	if matched:
		return null
	
	var value = inner.next();
	matched = pattern.call(value)
	if matched:
		return null
	
	return value
