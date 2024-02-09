extends Control

const ROWS: int = 4
const COLUMNS: int = 6

signal selected_location(location: Location)

@onready var locations_grid = $CenterContainer/List/LocationsGrid

func _ready():
	locations_grid.columns = COLUMNS
	var generator = Generator.new()
	var map = generator.random_map(COLUMNS, ROWS)
	
	for i in map.size():
		# reverse, so it's easier to navigate
		var y = map[map.size() - 1 - i]
		for x in y:
			var location_control = preload("res://UI/LocationControl.tscn").instantiate()
			location_control.location = x
			#location_control.map_position = Vector2i
			locations_grid.add_child(location_control)
