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
