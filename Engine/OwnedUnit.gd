extends Resource
class_name OwnedUnit

@export var base: Unit

@export var dmg: int
# size 3 to 8, 1 to 3 is true
@export var dmg_schedule: Schedule

@export var def: int
# size 3 to 8, 1 to 3 is true
@export var def_schedule: Schedule

@export var skill: Skill
# size 3 to 8, 1 to 3 is true
@export var skill_schedule: Schedule
