extends Iterator
class_name ArrayIterator

var array
var position: int

func _init(a):
	array = a
	position = 0

func next():
	while array.size() > position:
		var result = array[position]
		position += 1
		if result != null:
			return result
	return null

