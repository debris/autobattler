extends Control

@onready var team_a_control = $TeamA
@onready var team_b_control = $TeamB
@onready var team_a_power = $TeamAPower
@onready var team_b_power = $TeamBPower
@onready var round_label = $Round
@onready var phase_label = $Phase
@onready var console_logs = $ConsoleLogs
@onready var pause_button = $CanvasLayer/Control/Pause

var battle_state: BattleState
var battle_controller: BattleController
var paused = false

func _ready():
	battle_controller = BattleController.default()
	battle_controller.show_details.connect(func(battle_query):
		paused = true
		var details = load("res://UI/BattleUnitDetails.tscn").instantiate()
		details.battle_query = battle_query
		add_child(details)
	)

	var team_a = Team.new()
	var team_b = Team.new()

	for i in 6:
		team_a.members.push_back(random_unit())
		team_b.members.push_back(random_unit())

	battle_state = BattleState.new(team_a, team_b)
	team_a_control.battle_team_query = battle_state.team_a_query()
	team_b_control.battle_team_query = battle_state.team_b_query()
	team_a_power.battle_team = battle_state.team_a
	team_b_power.battle_team = battle_state.team_b

	battle_state.action_executed.connect(log_state.bind(battle_state))
	console_logs.battle_state = battle_state

	while true:
		await battle_state.execute_round()
		print("END OF ROUND: ", battle_state.round)
		await get_tree().create_timer(DisplaySettings.default().step_time).timeout

func log_state(state: BattleState):
	await get_tree().create_timer(DisplaySettings.default().step_time).timeout
	if !paused:
		state.proceed()

func _process(_delta):
	round_label.text = str(battle_state.round)
	phase_label.text = str(battle_state.phase + 1) + " of 3"
	
	if !paused:
		pause_button.text = "PAUSE"
	else:
		pause_button.text = "PLAY"

func random_unit() -> OwnedUnit:
	var unit = [
		UnitOrcWarrior.new(), 
		UnitElfArcher.new(), 
		UnitVikingWarrior.new(),
		UnitPrincessBhalu.new(),
		UnitAzureDragon.new(),
		UnitRubyAssassin.new(),
		UnitBeeMech.new(),
		UnitJackCross.new(),
		UnitOfficerJoe.new(),
		UnitMystique.new(),
		UnitLoki.new(),
		UnitPrime.new(),
		UnitHarmony.new(),
		UnitTinten.new(),
		UnitJanitor.new(),
		UnitBeeNinja.new()
	].pick_random()
	var owned_unit = claim_unit(unit)
	return owned_unit

func claim_unit(unit: Unit) -> OwnedUnit:
	var owned_unit = OwnedUnit.new()
	owned_unit.base = unit
	owned_unit.dmg = unit.dmg
	owned_unit.def = unit.def
	owned_unit.skill = unit.skill
	
	var generator = Generator.new(randi())

	owned_unit.schedules = [generator.rand_schedule(), generator.rand_schedule(), generator.rand_schedule()] as Array[Schedule]
	return owned_unit

func _on_pause_pressed():
	paused = !paused
	if !paused:
		battle_state.proceed()

func _on_console_pressed():
	console_logs.visible = !console_logs.visible

func _on_step_pressed():
	battle_state.proceed()
