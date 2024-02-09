extends Control

signal selected_location

@export var map: Map

@onready var list = $CenterContainer/List
@onready var locations_grid = $CenterContainer/List/LocationsGrid

func _ready():
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
				selected_location.emit()
			)
			locations_grid.add_child(location_control)
		
	var boss_control = preload("res://UI/LocationSpecialControl.tscn").instantiate()
	boss_control.location = LocationBoss.new()
	boss_control.map = map
	boss_control.map_position = Map.BOSS_POSITION
	boss_control.selected_location.connect(func(): 
		selected_location.emit()
	)
	list.add_child(boss_control)
	list.move_child(boss_control, 0)
	
	var start_control = preload("res://UI/LocationSpecialControl.tscn").instantiate()
	start_control.location = LocationStart.new()
	start_control.map = map
	start_control.map_position = Map.START_POSITION
	start_control.selected_location.connect(func(): 
		selected_location.emit()
	)
	list.add_child(start_control)
