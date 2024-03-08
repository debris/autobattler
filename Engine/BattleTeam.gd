extends Resource
class_name BattleTeam

const START_POWER_MULTIPLIER: int = 3

var power: int
var members: Array[BattleUnit]
var stacks: Stacks
var avatar: Avatar

func _init(team: Team, team_level: int = 0, a: Avatar = null):
	avatar = a
	power = 0
	members = []
	for unit in team.members:
		if unit != null:
			var battle_unit = BattleUnit.new(unit, team_level)
			power += battle_unit.def
			members.push_back(battle_unit)
		else:
			members.push_back(null)

	power *= START_POWER_MULTIPLIER
	stacks = Stacks.new()

func iterator() -> Iterator:
	return ArrayIterator.new(members)
