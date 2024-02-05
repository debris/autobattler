# Skill schedule
#
# Skill can be scheduled for X out of Y round (X / Y)
#
# 1/3 33%
# 1/4 25%
#
# 2/5 40%
# 2/6 33%
#
# 3/7 42%
# 3/8 37.5%
extends Resource
class_name Schedule

@export var data: Array[bool]

enum Kind {
	SKILL,
	DEF,
	DMG,
}

@export var kind = Kind.SKILL

func at(round: int) -> bool:
	return data[round % data.size()]

func set_active(round: int, active: bool):
	data[round % data.size()] = active

func normalize(round: int) -> int:
	return round % data.size()

func copy() -> Schedule:
	var result = Schedule.new()
	result.data = []
	result.data.append_array(data)
	result.kind = kind
	return result
