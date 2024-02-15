extends Iterator
class_name AlternateIterator

var first_iter: Iterator
var second_iter: Iterator

func _init(f, s):
	first_iter = f
	second_iter = s

func next():
	var value = first_iter.next()

	var tmp = first_iter
	first_iter = second_iter
	second_iter = tmp

	if value == null:
		value = first_iter.next()

	return value
