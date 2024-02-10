extends Iterator
class_name ConcatIterator

var first_iter: Iterator
var second_iter: Iterator

func _init(f, s):
	first_iter = f
	second_iter = s

func next():
	var value = first_iter.next()
	if value != null:
		return value
	return second_iter.next()
