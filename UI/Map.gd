extends Control

signal selected_location

@export var chapter: int
@export var map: Map
@export var avatar: Avatar
@export var dialog_progress: DialogProgress

@onready var list = $CenterContainer/ColorRect/CenterContainer/List
@onready var locations_grid = $CenterContainer/ColorRect/CenterContainer/List/LocationsGrid
@onready var global_overlay = $GlobalOverlay
@onready var chapter_label = $CenterContainer/ColorRect/CenterContainer/List/Control/ChapterLabel
@onready var avatar_control = $Avatar

var location_controls_by_position = {}

func _ready():
	global_overlay.exit_button.visible = true
	global_overlay.settings_button.visible = true
	global_overlay.character_button.visible = true
	global_overlay.team_button.visible = true
	
	chapter_label.text = tr("CHAPTER").format({"chapter": str(chapter)})

	locations_grid.columns = Map.COLUMNS

	for i in map.rows.size():
		# we display it from the bottom of the screen
		var y = map.rows[map.rows.size() - 1 - i]
		for ii in y.size():
			var x = y[ii]
			var location_control = preload("res://UI/LocationControl.tscn").instantiate()
			location_control.location = x
			location_control.map = map
			location_control.map_position = Vector2i(ii, map.rows.size() - 1 - i)
			location_control.selected_location.connect(func():
				avatar_travel_to_next_position()
			)
			locations_grid.add_child(location_control)
			mark_location_control(location_control)
		
	var boss_control = preload("res://UI/LocationSpecialControl.tscn").instantiate()
	boss_control.location = LocationBoss.new()
	boss_control.map = map
	boss_control.map_position = Map.BOSS_POSITION
	boss_control.selected_location.connect(func(): 
		avatar_travel_to_next_position()
	)
	list.add_child(boss_control)
	mark_location_control(boss_control)
	list.move_child(boss_control, 1)
	
	var start_control = preload("res://UI/LocationSpecialControl.tscn").instantiate()
	start_control.location = LocationStart.new()
	start_control.map = map
	start_control.map_position = Map.START_POSITION
	start_control.selected_location.connect(func(): 
		avatar_travel_to_next_position()
	)
	list.add_child(start_control)
	mark_location_control(start_control)
	
	if !dialog_progress.welcome_world_map:
		var dialog = Dialogs.display("0001_world_map_welcome")
		dialog.finished.connect(func():
			dialog_progress.welcome_world_map = true
		)

	avatar_control.texture = avatar.texture
	update_avatar_position.call_deferred()

func update_avatar_position():
	avatar_control.global_position = map_position_to_coordinates(map.map_position)

func avatar_travel_to_next_position():
	var tween = create_tween()
	var destination = map_position_to_coordinates(map.map_position)
	tween.tween_property(avatar_control, "global_position", destination, 1.0)
	await tween.finished
	selected_location.emit()

func mark_location_control(location_control: Control):
	location_controls_by_position[location_control.map_position] = location_control

func map_position_to_coordinates(position: Vector2i) -> Vector2:
	var location_control: Control = location_controls_by_position[position]
	return location_control.global_position + location_control.size / 2 - avatar_control.size / 2
