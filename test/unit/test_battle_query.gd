extends GutTest


var generator: Generator
var unit: BattleUnit
var team_a: Team
var team_b: Team
var battle_state: BattleState

func before_each():
	generator = Generator.new()
	unit = BattleUnit.new(generator.random_unit())
	team_a = Team.new()
	team_a.members = [null, null, null, null, null, null]
	team_b = generator.random_team(6)
	var battle_team_a = BattleTeam.new(team_a)
	var battle_team_b = BattleTeam.new(team_a)
	battle_state = BattleState.new(battle_team_a, battle_team_b)

func test_get_my_position():	
	battle_state.team_a.members[4] = unit

	var query = BattleQuery.new(unit, battle_state)
	var position = query.get_my_position()
	assert_eq(position.index, 4, "index should be equal to 4")

func test_get_my_position2():	
	battle_state.team_b.members[2] = unit

	var query = BattleQuery.new(unit, battle_state)
	var position = query.get_my_position()
	assert_eq(position.index, 2, "index should be equal to 2")


	