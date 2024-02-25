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

func as_string() -> String:
	var number = 0
	for i in data.size():
		number = number | (int(data[i]) << i)
	return "%x%x%02x" % [kind as int, data.size(), number]

func tier() -> String:
	var ok = 0
	var s = data.size()
	for i in s:
		if data[i]:
			ok += 1
	
	if ok == 1 && s == 3:
		return "C"
		
	if ok == 1 && s == 4:
		return "F"
	
	if ok == 2 && s == 5:
		return "A"
	
	if ok == 2 && s == 6:
		return "C"
	
	if ok == 3 && s == 7:
		return "S"
	
	if ok == 3 && s == 8:
		return "B"
	
	assert(false, "should be unreachable, logic error")
	return ""
