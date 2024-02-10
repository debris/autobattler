extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var orc_archer: BattleUnit
var orc_archer2: BattleUnit
var orc_archer3: BattleUnit
var janitor: BattleUnit
var janitor2: BattleUnit

func before_each():
	generator = Generator.new()
	team_a = generator.random_team(6)
	team_b = generator.random_team(6)
	var battle_team_a = BattleTeam.new(team_a)
	var battle_team_b = BattleTeam.new(team_a)
	battle_state = BattleState.new(battle_team_a, battle_team_b)
	orc_archer = BattleUnit.new(OwnedUnit.new(UnitOrcArcher.new(), team_a.members[0].schedules))
	orc_archer2 = BattleUnit.new(OwnedUnit.new(UnitOrcArcher.new(), team_a.members[0].schedules))
	orc_archer3 = BattleUnit.new(OwnedUnit.new(UnitOrcArcher.new(), team_a.members[0].schedules))
	janitor = BattleUnit.new(OwnedUnit.new(UnitJanitor.new(), team_a.members[0].schedules))
	janitor2 = BattleUnit.new(OwnedUnit.new(UnitJanitor.new(), team_a.members[0].schedules))

func test_orc_archer_no_allies():
	orc_archer.dmg = 10
	battle_state.team_a.members[0] = orc_archer
	battle_state.team_a.members[1] = null
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3] = janitor
	battle_state.team_a.members[4] = null
	battle_state.team_a.members[5] = janitor2
	
	var logs = orc_archer.skill._execute(BattleQuery.new(orc_archer, battle_state))
	
	assert_eq(logs.size(), 1, "there should be 1 log produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, orc_archer)
	assert_true(logs[0].skill is SkillArcherTraining)

func test_defence_sub_skill_with_allies():
	orc_archer.dmg = 10
	orc_archer2.dmg = 20
	orc_archer3.dmg = 30
	battle_state.team_a.members[0] = orc_archer
	battle_state.team_a.members[1] = orc_archer2
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3] = janitor
	battle_state.team_a.members[4] = orc_archer3
	battle_state.team_a.members[5] = janitor2
	
	var logs = orc_archer2.skill._execute(BattleQuery.new(orc_archer2, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, orc_archer2)
	assert_true(logs[0].skill is SkillArcherTraining)
	assert_true(logs[1] is LogDmgAdd)
	assert_eq(logs[1].unit, orc_archer2)
	assert_eq(logs[1].value, 4, "dmg should be increased by 20%")
