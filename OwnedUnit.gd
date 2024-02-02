extends Resource
class_name OwnedUnit

@export var base: Unit
@export var dmg: int
@export var dmg_rounds: Array[bool]
@export var def: int
@export var def_rounds: Array[bool]
@export var skill: Skill
@export var skill_rounds: Array[bool]

func is_dmg_active_at_round(round: int) -> bool:
	return dmg_rounds[dmg_rounds.size() % round]

func is_def_active_at_round(round: int) -> bool:
	return def_rounds[def_rounds.size() % round]

func is_skill_active_at_round(round: int) -> bool:
	return skill_rounds[skill_rounds.size() % round]
