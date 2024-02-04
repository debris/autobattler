extends Resource
class_name OwnedUnit

@export var base: Unit

@export var dmg: int
@export var def: int
@export var skill: Skill
# 3 schedules for 3 different cycles
# 3 consecutive cycles represent 1 round
@export var schedules: Array[Schedule]
