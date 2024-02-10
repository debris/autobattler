extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var princess_bhalu: BattleUnit
var schedules: Array[Schedule]
var same_round_schedules: Array[Schedule]
var not_matching_schedules: Array[Schedule]

func before_each():
	generator = Generator.new()
	team_a = generator.random_team(6)
	team_b = generator.random_team(6)
	battle_state = BattleState.new(team_a, team_b)
	
	schedules = [Schedule.new(), Schedule.new(), Schedule.new()]
	schedules[0].data = [true, false, false]
	schedules[0].kind = Schedule.Kind.DEF
	schedules[1].data = [false, false, true]
	schedules[1].kind = Schedule.Kind.DMG
	schedules[2].data = [false, false, true]
	schedules[2].kind = Schedule.Kind.SKILL
	
	same_round_schedules = [Schedule.new(), Schedule.new(), Schedule.new()]
	same_round_schedules[0].data = [true, false, false]
	same_round_schedules[0].kind = Schedule.Kind.DMG
	same_round_schedules[1].data = [true, false, false]
	same_round_schedules[1].kind = Schedule.Kind.SKILL
	same_round_schedules[2].data = [true, false, false]
	same_round_schedules[2].kind = Schedule.Kind.DEF
	
	not_matching_schedules = [Schedule.new(), Schedule.new(), Schedule.new()]
	not_matching_schedules[0].data = [false, true, false]
	not_matching_schedules[0].kind = Schedule.Kind.DEF
	not_matching_schedules[1].data = [false, true, false]
	not_matching_schedules[1].kind = Schedule.Kind.DMG
	not_matching_schedules[2].data = [false, false, true]
	not_matching_schedules[2].kind = Schedule.Kind.SKILL
	
	princess_bhalu = BattleUnit.new(OwnedUnit.new(UnitPrincessBhalu.new(), team_a.members[0].schedules))

func test_princess_bhalu_skill():
	battle_state.team_a.members[0] = princess_bhalu
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1].schedules = schedules
	battle_state.team_a.members[2].schedules = schedules
	var logs = princess_bhalu.skill._execute(BattleQuery.new(princess_bhalu, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, princess_bhalu)
	assert_true(logs[0].skill is SkillBearsMight)
	
	assert_true(logs[1] is LogDefBonusAdd)
	assert_eq(logs[1].unit, battle_state.team_a.members[1])
	assert_eq(logs[1].value, princess_bhalu.def)

func test_princess_bhalu_skill_different_schedules():
	battle_state.team_a.members[0] = princess_bhalu
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1].schedules = not_matching_schedules
	battle_state.team_a.members[2].schedules = schedules
	var logs = princess_bhalu.skill._execute(BattleQuery.new(princess_bhalu, battle_state))
	
	assert_eq(logs.size(), 1, "there should be 1 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, princess_bhalu)
	assert_true(logs[0].skill is SkillBearsMight)

func test_princess_bhalu_skill_null_ally():
	battle_state.team_a.members[0] = princess_bhalu
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1] = null
	battle_state.team_a.members[2] = null
	battle_state.team_a.members[3].schedules = schedules
	var logs = princess_bhalu.skill._execute(BattleQuery.new(princess_bhalu, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, princess_bhalu)
	assert_true(logs[0].skill is SkillBearsMight)
	assert_true(logs[1] is LogDefBonusAdd)
	assert_eq(logs[1].unit, battle_state.team_a.members[3])
	assert_eq(logs[1].value, princess_bhalu.def)
