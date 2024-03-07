extends GutTest

func test_schedule_compare_tiers():
	assert_true(Schedule.compare_tier("S", "A"))
	assert_true(Schedule.compare_tier("S", "S"))
	assert_true(!Schedule.compare_tier("A", "S"))
	assert_true(Schedule.compare_tier("A", "B"))
	assert_true(Schedule.compare_tier("B", "C"))
	assert_true(Schedule.compare_tier("A", "D"))
	assert_true(Schedule.compare_tier("B", "F"))
	assert_true(!Schedule.compare_tier("F", "S"))

