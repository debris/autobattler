extends Iterator
class_name OptionIterator

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

func map(callable):
	if value != null:
		return OptionIterator.new(callable.call(value))
	return self

func unwrap_or(or_value):
	if value != null:
		return value
	return or_value
