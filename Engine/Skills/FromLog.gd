# Simple wrapper for battle_log, useful when skill should be triggered from auction
extends Skill
class_name SkillFromLog

var battle_log = Log

func _init(l: Log, n: String, d: String):
	battle_log = l
	name = n
	description = d

func _execute(_query: BattleQuery) -> Array[Log]:
	return [battle_log]
