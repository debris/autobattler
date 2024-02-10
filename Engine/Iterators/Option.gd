extends Iterator
class_name Option

var value

func _init(v):
	value = v

func next():
	var result = value
	value = null
	return result

func is_some() -> bool:
	return value != null

func is_null() -> bool:
	return value == null

func get_value():
	return value
