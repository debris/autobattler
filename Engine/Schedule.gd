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
@tool
extends Resource
class_name Schedule

@export var data: Array[bool]

enum Kind {
	SKILL,
	DEF,
	DMG,
}

enum Tier {
	S,
	A,
	B,
	C,
	F
}

@export var kind = Kind.SKILL

# default schedule should be used to create units at the start of the new game
static func default_schedule(k: Kind) -> Schedule:
	var result = Schedule.new()
	# D tier schedule
	result.kind = k
	result.data.assign([false, false, false, true])
	return result

static func default_schedules() -> Array[Schedule]:
	return [Schedule.default_schedule(Kind.DEF), Schedule.default_schedule(Kind.DMG), Schedule.default_schedule(Kind.SKILL)]

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

func frequency() -> float:
	var ok = 0
	var s = data.size()
	for i in s:
		if data[i]:
			ok += 1
	
	return float(ok) / float(s)

func tier() -> String:
	var is_float_greater_or_equal = func(a, b):
		return a > b || is_zero_approx(a - b)

	var percent = frequency()

	if is_float_greater_or_equal.call(percent, 3.0 / 7.0):
		return "S"

	if is_float_greater_or_equal.call(percent, 2.0 / 5.0):
		return "A"

	if is_float_greater_or_equal.call(percent, 3.0 / 8.0):
		return "B"

	if is_float_greater_or_equal.call(percent, 1.0 / 3.0):
		return "C"

	if is_float_greater_or_equal.call(percent, 1.0 / 4.0):
		return "D"
	
	return "F"

static func compare_tier(a: String, b: String) -> bool:
	if a == "S":
		return true
	if b == "S":
		return false
	
	return a < b