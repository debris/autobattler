extends Resource
class_name Event

var name: String
var description: String
var options: Array[String]

func _selected_option(_index: int) -> Event:
	print_debug("UNIMPLEMENTED: Event 'selected_option'")
	return null
