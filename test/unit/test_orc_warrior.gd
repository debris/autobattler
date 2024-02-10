extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var orc_warrior: BattleUnit

func before_each():
	generator = Generator.new()
	team_a = generator.random_team(6)
	team_b = generator.random_team(6)
	battle_state = BattleState.new(team_a, team_b)
	orc_warrior = BattleUnit.new(OwnedUnit.new(UnitOrcWarrior.new(), team_a.members[0].schedules))

func test_orc_warrior_skill():
	battle_state.team_a.members[0] = orc_warrior
	var logs = orc_warrior.skill._execute(BattleQuery.new(orc_warrior, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, orc_warrior)
	assert_true(logs[0].skill is SkillBloodRage)
	assert_true(logs[1] is LogDmgAdd)
	assert_eq(logs[1].unit, orc_warrior)
	assert_eq(logs[1].value, 2, "dmg should be increase by 20%")

func test_orc_warrior_skill_scaling():
	battle_state.team_a.members[0] = orc_warrior
	orc_warrior.dmg = 20
	var logs = orc_warrior.skill._execute(BattleQuery.new(orc_warrior, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, orc_warrior)
	assert_true(logs[0].skill is SkillBloodRage)
	assert_true(logs[1] is LogDmgAdd)
	assert_eq(logs[1].unit, orc_warrior)
	assert_eq(logs[1].value, 4, "dmg should be increase by 20%")
