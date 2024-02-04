# Skill execution environment, links skill and unit together
extends Resource
class_name ExecutionEnv

var battle_unit: BattleUnit
var skill: Skill

func _init(u: BattleUnit, s: Skill):
	battle_unit = u
	skill = s
