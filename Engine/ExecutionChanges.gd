extends Resource
class_name ExecutionChanges

var battle_unit: BattleUnit
var skill: Skill
var execution_logs: Array[Log]
var depth: int

func _init(u: BattleUnit, s: Skill, el: Array[Log], d = 0):
	battle_unit = u
	skill = s
	execution_logs = el
	depth = d
