extends GutTest

var generator: Generator
var team_a: Team
var team_b: Team
var battle_state: BattleState
var azure_dragon: BattleUnit
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
	schedules[0].kind = Schedule.Kind.SKILL
	schedules[1].data = [false, false, true]
	schedules[1].kind = Schedule.Kind.DMG
	schedules[2].data = [false, false, true]
	schedules[2].kind = Schedule.Kind.DEF
	
	same_round_schedules = [Schedule.new(), Schedule.new(), Schedule.new()]
	same_round_schedules[0].data = [true, false, false]
	same_round_schedules[0].kind = Schedule.Kind.DMG
	same_round_schedules[1].data = [true, false, false]
	same_round_schedules[1].kind = Schedule.Kind.SKILL
	same_round_schedules[2].data = [false, false, true]
	same_round_schedules[2].kind = Schedule.Kind.DEF
	
	not_matching_schedules = [Schedule.new(), Schedule.new(), Schedule.new()]
	not_matching_schedules[0].data = [false, true, false]
	not_matching_schedules[0].kind = Schedule.Kind.SKILL
	not_matching_schedules[1].data = [false, true, false]
	not_matching_schedules[1].kind = Schedule.Kind.DMG
	not_matching_schedules[2].data = [false, false, true]
	not_matching_schedules[2].kind = Schedule.Kind.DEF
	
	azure_dragon = BattleUnit.new(OwnedUnit.new(UnitAzureDragon.new(), team_a.members[0].schedules))

func test_azure_dragon_skill():
	battle_state.team_a.members[0] = azure_dragon
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1].schedules = schedules
	battle_state.team_a.members[2].schedules = schedules
	var logs = azure_dragon.skill._execute(BattleQuery.new(azure_dragon, battle_state))
	
	assert_eq(logs.size(), 3, "there should be 3 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, azure_dragon)
	assert_true(logs[0].skill is SkillAzureMomentum)
	assert_true(logs[1] is LogSkillCastBonus)
	assert_eq(logs[1].unit, battle_state.team_a.members[1])
	assert_eq(logs[1].value, 1)
	assert_true(logs[2] is LogSkillCastBonus)
	assert_eq(logs[2].unit, battle_state.team_a.members[2])
	assert_eq(logs[2].value, 1)

func test_azure_dragon_skill_different_schedules():
	battle_state.team_a.members[0] = azure_dragon
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1].schedules = not_matching_schedules
	battle_state.team_a.members[2].schedules = same_round_schedules
	var logs = azure_dragon.skill._execute(BattleQuery.new(azure_dragon, battle_state))
	
	assert_eq(logs.size(), 1, "there should be 1 log produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, azure_dragon)

func test_azure_dragon_skill_null_ally():
	battle_state.team_a.members[0] = azure_dragon
	battle_state.team_a.members[0].schedules = schedules
	battle_state.team_a.members[1] = null
	battle_state.team_a.members[2].schedules = schedules
	battle_state.team_a.members[3].schedules = not_matching_schedules
	battle_state.team_a.members[4].schedules = schedules
	var logs = azure_dragon.skill._execute(BattleQuery.new(azure_dragon, battle_state))
	
	assert_eq(logs.size(), 2, "there should be 2 logs produced")
	assert_true(logs[0] is LogSkillUsed)
	assert_eq(logs[0].unit, azure_dragon)
	assert_true(logs[1] is LogSkillCastBonus)
	assert_eq(logs[1].unit, battle_state.team_a.members[2])
	assert_eq(logs[1].value, 1)
