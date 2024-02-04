extends Resource
class_name GameColors

static func schedule_color(schedule_kind: Schedule.Kind) -> Color:
	match schedule_kind:
		Schedule.Kind.SKILL: return GameColors.blue()
		Schedule.Kind.DEF: return GameColors.green()
		Schedule.Kind.DMG: return GameColors.red()
	assert(false)
	return Color.WHITE

static func red() -> Color:
	var color = Color(1, 0, 0)
	color.s = 0.5
	color.v = 0.5
	return color

static func green() -> Color:
	var color = Color(0, 1, 0)
	color.s = 0.5
	color.v = 0.5
	return color

static func blue() -> Color:
	var color = Color(0, 0, 1)
	color.s = 0.5
	color.v = 0.5
	return color

static func yellow() -> Color:
	var color = Color.YELLOW
	color.s = 0.5
	color.v = 0.5
	return color

static func black() -> Color:
	var color = Color.BLACK
	color.s = 0.5
	color.v = 0.5
	return color
