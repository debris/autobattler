extends Iterator
class_name Option

var value

func _init(v):
	value = v

func next():
	var result = value
	value = null
	return result
