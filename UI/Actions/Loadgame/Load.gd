extends LoadgameAction
class_name LoadgameActionLoad

var save: Save
var save_name: String

func _init(s, n):
	save = s
	save_name = n
