# Simple wrapper for log, useful when skill should be triggered from auction
extends Skill
class_name SkillFromLog

var log = Log

func _init(l: Log, n: String, d: String):
	log = l
	name = n
	description = d

func _execute(query: BattleQuery) -> Array[Log]:
	return [log]
