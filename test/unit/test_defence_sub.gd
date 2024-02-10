extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var defence_sub: BattleUnit
var defence_sub2: BattleUnit
var defence_sub3: BattleUnit
var janitor: BattleUnit
var janitor2: BattleUnit

func before_each():
	generator = Generator.new()
	team_a = generator.random_team(6)
	team_b = generator.random_team(6)
	var battle_team_a = BattleTeam.new(team_a)
	var battle_team_b = BattleTeam.new(team_a)
	battle_state = BattleState.new(battle_team_a, battle_team_b)
	defence_sub = BattleUnit.new(OwnedUnit.new(UnitDefenceSub.new(), team_a.members[0].schedules))
	defence_sub2 = BattleUnit.new(OwnedUnit.new(UnitDefenceSub.new(), team_a.members[0].schedules))
	defence_sub3 = BattleUnit.new(OwnedUnit.new(UnitDefenceSub.new(), team_a.members[0].schedules))
	janitor = BattleUnit.new(OwnedUnit.new(UnitJanitor.new(), team_a.members[0].schedules))
	janitor2 = BattleUnit.new(OwnedUnit.new(UnitJanitor.new(), team_a.members[0].schedules))

func test_defence_sub_skill_no_allies():
	defence_sub.def = 10
	battle_state.team_a.members[0] = defence_sub
	battle_state.team_a.members[1] = null
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3] = janitor
	battle_state.team_a.members[4] = null
	battle_state.team_a.members[5] = janitor2
	
	var logs = defence_sub.skill._execute(BattleQuery.new(defence_sub, battle_state))
	
	assert_eq(logs.size(), 1, "there should be 1 log produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, defence_sub)
	assert_true(logs[0].skill is SkillBlue42)

func test_defence_sub_skill_with_allies():
	defence_sub.def = 10
	defence_sub2.def = 20
	defence_sub3.def = 30
	battle_state.team_a.members[0] = defence_sub
	battle_state.team_a.members[1] = defence_sub2
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3] = janitor
	battle_state.team_a.members[4] = defence_sub3
	battle_state.team_a.members[5] = janitor2
	
	var logs = defence_sub2.skill._execute(BattleQuery.new(defence_sub2, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, defence_sub2)
	assert_true(logs[0].skill is SkillBlue42)
	assert_true(logs[1] is LogDefAdd)
	assert_eq(logs[1].unit, defence_sub2)
	assert_eq(logs[1].value, 4, "def should be increased by 20%")
	
