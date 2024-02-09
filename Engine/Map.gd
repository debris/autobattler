extends Resource
class_name Map

const ROWS: int = 4
const COLUMNS: int = 6
const START_POSITION = Vector2i(-1, -1)
const BOSS_POSITION = Vector2i(-1, -2)

# rows is Array[Array[Location]]
# unfortunately we cannot declare nested array in godot (wtf?)
var rows
var map_position: Vector2i

func _init():
	rows = []
	map_position = START_POSITION

func is_valid_destination(destination: Vector2i) -> bool:
	if map_position == START_POSITION && destination.y == 0:
		return true
	
	if destination == BOSS_POSITION && map_position.y == rows.size() - 1:
		return true
	
	if rows[destination.y][destination.x] is LocationEmpty:
		return false

	if map_position.y + 1 == destination.y && destination.x >= map_position.x - 1 && destination.x <= map_position.x + 1:
		return true

	return false

# returns null if we are in the start position
func current_location() -> Location:
	if map_position == BOSS_POSITION:
		return LocationBoss.new()
	
	if map_position == START_POSITION:
		return LocationStart.new()

	return rows[map_position.y][map_position.x]
