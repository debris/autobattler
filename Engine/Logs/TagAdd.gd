extends Log
class_name LogTagAdd

var tag: String

func _init(u, t):
	unit = u
	tag = t

func _finalize(_battle_state: BattleState):
	unit.tags[tag] = null

func _to_string() -> String:
	return unit.name + " gets tag " + tag
