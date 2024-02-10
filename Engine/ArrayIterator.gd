extends Object
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

func filter(filter_function) -> FilterIterator:
	return FilterIterator.new(self, filter_function)

func limit(number: int) -> LimitIterator:
	return LimitIterator.new(self, number)

func for_each(for_each_function):
	var item = next()
	while item != null:
		for_each_function.call(item)
		item = next()
