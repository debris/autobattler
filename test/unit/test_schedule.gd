extends GutTest

func test_schedule_as_string0():
	var schedule = Schedule.new()
	schedule.kind = Schedule.Kind.SKILL
	schedule.data = [true, false, false] as Array[bool]
	assert_eq("0301", schedule.as_string())

func test_schedule_as_string1():
	var schedule = Schedule.new()
	schedule.kind = Schedule.Kind.DEF
	schedule.data = [true, false, false, false] as Array[bool]
	assert_eq("1401", schedule.as_string())

func test_schedule_as_string2():
	#var color = GameColors.red()
	#var c_as_str = "%02x%02x%02x" % [color.r * 255.0, color.g * 255.0, color.b * 255.0]
	#assert_eq("aaa", c_as_str)
	
	var schedule = Schedule.new()
	schedule.kind = Schedule.Kind.DMG
	schedule.data = [false, false, true, true, false] as Array[bool]
	assert_eq("250c", schedule.as_string())
