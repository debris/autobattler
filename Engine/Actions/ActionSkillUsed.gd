extends Action
class_name ActionSkillUsed

var name: String
var success: bool

func _init(u, n, s = true):
	unit = u
	name = n
	success = s
