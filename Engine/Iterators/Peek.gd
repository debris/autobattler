extends Iterator
class_name PeekIterator

var inner: Iterator
var cache = null

func _init(i):
	inner = i

func next():
	if cache != null:
		var result = cache
		cache = null
		return result
	
	return inner.next()

func peek():
	if cache != null:
		return cache
	
	cache = inner.next()
	return cache
