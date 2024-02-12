extends Log
class_name LogStacksAdd

var team: BattleTeam
var kind: Stacks.Kind
var value: int

func _init(u: BattleUnit, t: BattleTeam, k: Stacks.Kind, v: int):
	# unit and team may be different if unit is changing values for opposite team
	unit = u
	team = t
	kind = k
	value = v

func _finalize(_battle_state: BattleState):
	team.stacks.increase_by(kind, value)

func _to_string() -> String:
	if value > 0:
		return unit.name + " increases " + Stacks.Kind.keys()[kind].to_lower() + " stacks by " + str(value)
	else:
		return unit.name + " decreases " + Stacks.Kind.keys()[kind].to_lower() + " stacks by " + str(value)
