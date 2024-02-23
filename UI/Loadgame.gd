extends Control

signal action_selected(LoadgameAction)

@onready var saves_list = $Border/ScrollContainer/Saves
@onready var preview_control = $CenterContainer/Preview
@onready var save_name_label = $CenterContainer/Preview/SaveName
@onready var chapter_label = $CenterContainer/Preview/ChapterLabel
@onready var level_label = $CenterContainer/Preview/LevelLabel
@onready var units_label = $CenterContainer/Preview/UnitsLabel
@onready var team_list = $CenterContainer/Preview/CenterContainer/TeamList
@onready var delete_button = $BottomPanel/GridContainer/DeleteButton
@onready var load_button = $BottomPanel/GridContainer/LoadButton
@onready var global_overlay = $GlobalOverlay

var save_preview: Save:
	set(value):
		save_preview = value
		if is_node_ready():
			display_preview()
var save_name: String

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true
	var all_saves_names = Save.all_saves()
	var all_saves = all_saves_names.map(func(n): return Save.load_save(n))
	var pairs: Array = ArrayIterator.new(all_saves_names).zip(ArrayIterator.new(all_saves)).collect()
	pairs.sort_custom(func(tuple_a, tuple_b):
		return tuple_a.b.utc_savetime > tuple_b.b.utc_savetime
	)
	
	for save_tuple in pairs:
		var label = preload("res://UI/LoadgameEntry.tscn").instantiate()
		
		label.text = save_tuple.a
		label.utc_time = save_tuple.b.utc_savetime
		label.selected.connect(func():
			save_name = save_tuple.a
			save_preview = save_tuple.b
		)
		saves_list.add_child(label)

	display_preview()
	DisplaySettings.default().language_changed.connect(display_preview)

func _on_unit_control_pressed(unit):
	var details = load("res://UI/UnitDetails.tscn").instantiate()
	details.unit = unit
	global_overlay.present_subview(details)

func display_preview():
	if save_preview == null:
		preview_control.visible = false
		delete_button.disabled = true
		load_button.disabled = true
		return
	
	delete_button.disabled = false
	load_button.disabled = false
	preview_control.visible = true
	save_name_label.text = save_name
	chapter_label.text = tr("CHAPTER").format({"chapter": str(save_preview.chapter)})
	level_label.text = tr("LEVEL").format({"level": str(save_preview.player_team_level)})
	# bench size + not null members
	var units_count = str(save_preview.count_units())
	units_label.text = tr("UNITS").format({"units": str(units_count)})

	var unit_controls = team_list.get_children()
	for i in 6:
		unit_controls[i].unit = save_preview.team.members[i]

func _on_new_game_button_pressed():
	action_selected.emit(LoadgameActionNew.new())

func _on_delete_button_pressed():
	if save_name != null && save_name != "":
		var delete_control = preload("res://UI/Question.tscn").instantiate()
		delete_control.question_text = tr("CONFIRM_DELETE_SAVE")
		delete_control.cancel_pressed.connect(func():
			delete_control.queue_free()
		)
		global_overlay.present_subview(delete_control)
		await delete_control.yes_pressed
		delete_control.queue_free()

		Save.delete(save_name)
		for load_entry in saves_list.get_children():
			if load_entry.text == save_name:
				load_entry.queue_free()
				break
		save_name = ""
		save_preview = null
		display_preview()

func _on_start_button_pressed():
	if save_preview != null:
		action_selected.emit(LoadgameActionLoad.new(save_preview, save_name))
