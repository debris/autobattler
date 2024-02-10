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

func is_skill() -> bool:
	return kind == Schedule.Kind.SKILL

func is_defence() -> bool:
	return kind == Schedule.Kind.DEF

func at(r: int) -> bool:
	return data[r % data.size()]

func set_active(r: int, active: bool):
	data[r % data.size()] = active

func normalize(r: int) -> int:
	return r % data.size()

func copy() -> Schedule:
	var result = Schedule.new()
	result.data.append_array(data)
	result.kind = kind
	return result
