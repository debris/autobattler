# Skill execution environment, links skill and unit together
extends Resource
class_name ExecutionEnv

var battle_unit: BattleUnit
var skill: Skill

func _init(u: BattleUnit, s: Skill):
	battle_unit = u
	skill = s

func execute(battle_state: BattleState) -> ExecutionChanges:
	return ExecutionChanges.new(skill._execute(BattleQuery.new(battle_unit, battle_state)))
