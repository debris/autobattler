extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var orc_shaman: BattleUnit
var orc_shaman2: BattleUnit
var orc_warrior: BattleUnit
var orc_archer: BattleUnit
var janitor: BattleUnit

func before_each():
	generator = Generator.new()
	team_a = generator.random_team(6)
	team_b = generator.random_team(6)
	battle_state = BattleState.new(team_a, team_b)
	orc_shaman = BattleUnit.new(OwnedUnit.new(UnitOrcShaman.new(), team_a.members[0].schedules))
	orc_shaman2 = BattleUnit.new(OwnedUnit.new(UnitOrcShaman.new(), team_a.members[0].schedules))
	orc_warrior = BattleUnit.new(OwnedUnit.new(UnitOrcWarrior.new(), team_a.members[0].schedules))
	orc_archer = BattleUnit.new(OwnedUnit.new(UnitOrcArcher.new(), team_a.members[0].schedules))
	janitor = BattleUnit.new(OwnedUnit.new(UnitJanitor.new(), team_a.members[0].schedules))

func test_orc_shaman_skill():
	orc_warrior.def = 20
	orc_shaman2.def = 30
	battle_state.team_a.members[0] = orc_shaman
	battle_state.team_a.members[1] = janitor
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3] = orc_warrior
	battle_state.team_a.members[4] = orc_archer
	battle_state.team_a.members[5] = orc_shaman2
	
	var logs = orc_shaman2.skill._execute(BattleQuery.new(orc_shaman2, battle_state))
	
	assert_eq(logs.size(), 5, "there should be 5 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, orc_shaman2)
	assert_true(logs[0].skill is SkillDefenceRitual)
	assert_true(logs[1] is LogDefAdd)
	assert_eq(logs[1].unit, orc_shaman)
	assert_eq(logs[1].value, 1, "def should be increase by 10%")
	assert_true(logs[2] is LogDefAdd)
	assert_eq(logs[2].unit, orc_warrior)
	assert_eq(logs[2].value, 2, "def should be increase by 10%")
	assert_true(logs[3] is LogDefAdd)
	assert_eq(logs[3].unit, orc_archer)
	assert_eq(logs[3].value, 1, "def should be increase by 10%")
	assert_true(logs[4] is LogDefAdd)
	assert_eq(logs[4].unit, orc_shaman2)
	assert_eq(logs[4].value, 3, "def should be increase by 10%")
