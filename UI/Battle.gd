extends Control

@onready var team_a_control = $TeamA
@onready var team_b_control = $TeamB
@onready var team_a_power = $TeamAPower
@onready var team_b_power = $TeamBPower
@onready var round_label = $Round
@onready var phase_label = $Phase
@onready var console_logs = $ConsoleLogs
@onready var pause_button = $CanvasLayer/Control/Pause
@onready var step_button = $CanvasLayer/Control/Step
@onready var start_button = $Start
@onready var victory_label = $VictoryLabel
@onready var change_grid = $ChangeGrid

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
	battle_controller.move_unit_left.connect(func(i): 
		if i > 0:
			var members = battle_state.team_b.members
			var tmp = members[i - 1]
			members[i - 1] = members[i]
			members[i] = tmp
			team_b_control.refresh()
	)
	battle_controller.move_unit_right.connect(func(i): 
		var members = battle_state.team_b.members
		if i < members.size() - 1:
			var tmp = members[i + 1]
			members[i + 1] = members[i]
			members[i] = tmp
			team_b_control.refresh()
	)

	var team_a = Team.new()
	var team_b = Team.new()

	var generator = Generator.new(10)
	for i in 6:
		team_a.members.push_back(generator.random_unit())
		#team_a.members.push_back(null)
		
	for i in 6:
		team_b.members.push_back(generator.random_unit())

	battle_state = BattleState.new(team_a, team_b)
	team_a_control.battle_team_query = battle_state.team_a_query()
	team_b_control.battle_team_query = battle_state.team_b_query()
	team_a_power.battle_team = battle_state.team_a
	team_b_power.battle_team = battle_state.team_b

	battle_state.action_executed.connect(_wait_for_display)
	console_logs.battle_state = battle_state

# private
func _wait_for_display():
	await get_tree().create_timer(DisplaySettings.default().step_time).timeout
	
	var victory = battle_state.team_a.power <= 0
	var defeat = battle_state.team_b.power <= 0
	var tie = victory && defeat
	
	if tie:
		return on_battle_end("tie")
	
	if victory:
		return on_battle_end("victory")

	if defeat:
		return on_battle_end("defeat")
	
	if !paused:
		battle_state.proceed()

func on_battle_end(result):
	victory_label.visible = true
	victory_label.text = result
	step_button.visible = false
	pause_button.visible = false
	paused = true

func _process(_delta):
	round_label.text = str(battle_state.round + 1)
	phase_label.text = str(battle_state.phase + 1) + " of 3"
	
	if !paused:
		pause_button.text = "PAUSE"
	else:
		pause_button.text = "PLAY"

func _on_pause_pressed():
	paused = !paused
	if !paused:
		battle_state.proceed()

func _on_console_pressed():
	console_logs.visible = !console_logs.visible

func _on_step_pressed():
	battle_state.proceed()

func _on_start_pressed():
	paused = false
	start_button.visible = false
	step_button.visible = true
	pause_button.visible = true
	change_grid.visible = false

	while true:
		await battle_state.execute_round()
