extends Iterator
class_name ZipIterator

var first_iter: Iterator
var second_iter: Iterator

func _init(f, s):
	first_iter = f
	second_iter = s

func next():
	var f_val = first_iter.next()
	var s_val = second_iter.next()
	
	if f_val != null || s_val != null:
		return Tuple.new(f_val, s_val)
	
	return null
