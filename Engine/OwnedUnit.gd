extends Resource
class_name OwnedUnit

@export var base: Unit

@export var name: String
@export var texture: Texture2D
@export var dmg: int
@export var def: int
@export var abilities: Array[Ability]
@export var tags: Dictionary
@export var schedules: Array[Schedule]
@export var empowered: int

# the empty constructor should not be used, but is REQUIRED by godots serializer
func _init(b: Unit = Unit.new(), ss: Array[Schedule] = Schedule.default_schedules()):
	base = b
	name = b.name
	texture = b.texture
	dmg = b.dmg
	def = b.def
	abilities = []
	abilities.assign(b.abilities)

	tags = {}
	for tag in b.tags:
		tags[tag] = null

	schedules = ss
	empowered = 0

func display_serial_number() -> String:
	return " ".join(schedules.map(func(s):
		var color: Color
		match s.kind:
			Schedule.Kind.SKILL: color = GameColors.blue()
			Schedule.Kind.DEF: color = GameColors.green()
			Schedule.Kind.DMG: color = GameColors.red()
		return "[color=%s]%s[/color]" % [color.to_html(false), s.as_string()]
	))
