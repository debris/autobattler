# Position of BattleUnit within it's team
extends Resource
class_name BattleUnitPosition

var battle_team: BattleTeam
var index: int

func _init(t: BattleTeam, i: int):
	battle_team = t
	index = i

func is_last() -> bool:
	return index == battle_team.members.size() - 1
