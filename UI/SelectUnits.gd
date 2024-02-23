extends Control

signal reroll_button_pressed
signal selected_units(units: Array[OwnedUnit])

@export var to_select: int = 2
@export var out_of: Team:
	set(value):
		out_of = value
		if is_node_ready():
			update_display()
			
@export var player_team_level: int
@export var title_text: String
@export var reroll_button_visible: bool = false
@export var team_button_visible: bool = false
@export var dialog_progress: DialogProgress

@onready var select_label = $SelectLabel
@onready var team_list = $TeamList
@onready var select_button_grid = $SelectButtonGrid
@onready var reroll_button = $RerollButton

@onready var global_overlay = $GlobalOverlay

var selected: Array[OwnedUnit] = []

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true
	global_overlay.help_button.visible = true
	global_overlay.team_button.visible = team_button_visible
	
	reroll_button.visible = reroll_button_visible
	select_label.text = title_text
	
	for button in select_button_grid.get_children():
		button.pressed.connect(_on_select_button_pressed.bind(button))
	
	# TODO: better condition to check if this is a first run
	if !dialog_progress.welcome_select_units:
		var dialog = Dialogs.display("0000_select_units_welcome")
		dialog.finished.connect(func():
			dialog_progress.welcome_select_units = true
		)
	
	update_display()

func update_display():
	assert(out_of.members.size() == 6, "for now only 6 is supported")
	var unit_controls = team_list.get_children()
	for i in 6:
		unit_controls[i].unit = out_of.members[i]

func _on_select_button_pressed(button):
	var index = button.get_index()
	selected.push_back(out_of.members[index])
	out_of.members[index] = null
	button.disabled = true
	button.release_focus()
	button.focus_mode = FOCUS_NONE
	update_display()
	
	if selected.size() == to_select:
		selected_units.emit(selected)

func _on_reroll_button_pressed():
	reroll_button_pressed.emit()

func _on_unit_control_pressed(unit):
	var details = load("res://UI/UnitDetails.tscn").instantiate()
	details.unit = unit
	global_overlay.present_subview(details)
