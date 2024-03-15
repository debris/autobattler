extends Log
class_name LogAvatarPassive

var avatar: Avatar

func _init(u, a: Avatar):
	unit = u
	avatar = a

func _finalize(_battle_state: BattleState):
	pass

func _to_string() -> String:
	return avatar.name + " avatar passive activated by " + unit.name
