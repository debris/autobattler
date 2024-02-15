extends Resource
class_name OwnedUnit

@export var base: Unit

@export var dmg: int
@export var def: int
@export var skill: Skill
@export var schedules: Array[Schedule]

func _init(b: Unit, ss: Array[Schedule]):
	base = b
	dmg = b.dmg
	def = b.def
	skill = b.skill
	schedules = ss

func display_serial_number() -> String:
	return " ".join(schedules.map(func(s):
		var color: Color
		match s.kind:
			Schedule.Kind.SKILL: color = GameColors.blue()
			Schedule.Kind.DEF: color = GameColors.green()
			Schedule.Kind.DMG: color = GameColors.red()
		return "[color=%s]%s[/color]" % [color.to_html(false), s.as_string()]
	))
