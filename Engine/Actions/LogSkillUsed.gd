extends Log
class_name LogSkillUsed

var name: String
var success: bool

func _init(u, n, s = true):
	unit = u
	name = n
	success = s
