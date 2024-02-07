extends Resource
class_name BattleTeam

const START_POWER_MULTIPLIER: int = 3

var power: int
var members: Array[BattleUnit]

func _init(team: Team):
	power = 0
	members = []
	for unit in team.members:
		power += unit.def
		var battle_unit = BattleUnit.new(unit)
		members.push_back(battle_unit)

	power *= START_POWER_MULTIPLIER
