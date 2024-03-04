extends Resource
class_name QueuePosition

var unit: BattleUnit
var battle_round: int
var battle_phase: int

func _init(u: BattleUnit, r: int, p: int):
	unit = u
	battle_round = r
	battle_phase = p

func is_equal(other: QueuePosition):
	return battle_round == other.battle_round && battle_phase == other.battle_phase && unit == other.unit