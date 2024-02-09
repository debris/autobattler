extends Control

signal selected_location

@export var map: Map

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
