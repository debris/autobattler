extends Control

signal selected_units(units: Array[OwnedUnit])

@export var to_select: int = 2
@export var out_of: Team
@export var player_team_level: int

@onready var select_label = $SelectLabel
@onready var battle_team_control = $BattleTeamControl
@onready var select_button_grid = $SelectButtonGrid

var displayed_team: BattleTeam
var selected: Array[OwnedUnit] = []

func _ready():
	select_label.text = "Select " + str(to_select)
	var battle_controller = BattleController.default()
	battle_controller.show_details.connect(func(battle_query):
		var details = load("res://UI/BattleUnitDetails.tscn").instantiate()
		details.battle_query = battle_query
		add_child(details)
	)
	
	var battle_state = BattleState.new(BattleTeam.new(out_of, player_team_level), BattleTeam.new(Team.null_team()))
	displayed_team = battle_state.team_a
	battle_team_control.battle_team_query = battle_state.team_a_query()
	
	for button in select_button_grid.get_children():
		button.pressed.connect(_on_select_button_pressed.bind(button))

func _on_select_button_pressed(button):
	var index = button.get_index()
	selected.push_back(displayed_team.members[index].unit)
	displayed_team.members[index] = null
	button.disabled = true
	battle_team_control.refresh()
	
	if selected.size() == to_select:
		selected_units.emit(selected)
	
