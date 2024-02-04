extends Resource
class_name OwnedUnit

@export var base: Unit

@export var dmg: int
@export var def: int
@export var skill: Skill
# 3 schedules for 3 different cycles
# 3 consecutive cycles represent 1 round, aka day
# morning, afternoon, night
@export var schedules: Array[Schedule]


## size 3 to 8, 1 to 3 is true
#@export var dmg_schedule: Schedule
## size 3 to 8, 1 to 3 is true
#@export var def_schedule: Schedule
## size 3 to 8, 1 to 3 is true
#@export var skill_schedule: Schedule
