extends Resource
class_name OwnedUnit

@export var base: Unit

@export var dmg: int
# size 3 to 8, 1 to 3 is true
@export var dmg_rounds: Array[bool]

@export var def: int
# size 3 to 8, 1 to 3 is true
@export var def_rounds: Array[bool]

@export var skill: Skill
# size 3 to 8, 1 to 3 is true
@export var skill_rounds: Array[bool]

func is_dmg_active_at_round(round: int) -> bool:
	return dmg_rounds[round % dmg_rounds.size()]

func is_def_active_at_round(round: int) -> bool:
	return def_rounds[round % def_rounds.size()]

func is_skill_active_at_round(round: int) -> bool:
	return skill_rounds[round % skill_rounds.size()]
