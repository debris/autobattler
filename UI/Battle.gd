extends Node2D

@onready var team_a_control = $CenterContainer/GridContainer/TeamA
@onready var team_b_control = $CenterContainer/GridContainer/TeamB
@onready var round_label = $Round

var battle_state: BattleState

func _ready():
	var team_a = Team.new()
	var team_b = Team.new()
	
	for i in 3:
		team_a.members.push_back(random_unit())
		team_b.members.push_back(random_unit())

	battle_state = BattleState.new(team_a, team_b)
	team_a_control.battle_team = battle_state.team_a
	team_b_control.battle_team = battle_state.team_b
	
	battle_state.action_executed.connect(log_state.bind(battle_state))
	
	while true:
		await battle_state.execute_round()
		print("END OF ROUND: ", battle_state.round)
		await get_tree().create_timer(3.0).timeout

func log_state(a, battle_state):
	print_debug("LOG action: ", a)
	await get_tree().create_timer(0.5).timeout
	battle_state.proceed()

func _process(delta):
	round_label.text = "ROUND: " + str(battle_state.round)

func random_unit() -> OwnedUnit:
	var unit = [UnitOrcWarrior.new(), UnitElfArcher.new(), UnitVikingWarrior.new()].pick_random()
	var owned_unit = claim_unit(unit)
	return owned_unit

func claim_unit(unit: Unit) -> OwnedUnit:
	var owned_unit = OwnedUnit.new()
	owned_unit.base = unit
	owned_unit.dmg = unit.dmg
	owned_unit.def = unit.def
	owned_unit.skill = unit.skill
	
	owned_unit.dmg_schedule = random_schedule()
	owned_unit.def_schedule = random_schedule()
	owned_unit.skill_schedule = random_schedule()
	return owned_unit

func random_schedule() -> Schedule:
	# TODO: do it properly
	var schedule = Schedule.new()
	schedule.data = [true, false, false] as Array[bool]
	return schedule
