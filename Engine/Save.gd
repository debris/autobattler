extends Resource
class_name Save

@export var team: Team
@export var bench: Array[OwnedUnit]
@export var chapter: int
@export var player_team_level: int
@export var utc_savetime: String

func _init():
	team = Team.new()
	bench = []
	chapter = 0
	player_team_level = 0
	utc_savetime = ""

func all_units() -> Iterator:
	return ArrayIterator.new(team.members).concat(ArrayIterator.new(bench))

func count_units() -> int:
	return bench.size() + ArrayIterator.new(team.members).count()

static func save_name(index: String) -> String:
	return "savefile" + index + ".tres"

static func save_path(index: String) -> String:
	return "user://" + save_name(index)

func write_save(index):
	utc_savetime = Time.get_datetime_string_from_system(true)
	ResourceSaver.save(self, Save.save_path(index))
	
static func load_save(index) -> Save:
	if ResourceLoader.exists(save_path(index)):
		return ResourceLoader.load(save_path(index), "", ResourceLoader.CACHE_MODE_IGNORE)
	return null

static func exists(index) -> bool:
	return ResourceLoader.exists(save_path(index))

static func delete(index):
	var dir = DirAccess.open("user://")
	dir.remove(save_name(index))

static func all_saves() -> Array[String]:
	var dir = DirAccess.open("user://")
	var result: Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.contains("savefile"):
				var i = file_name.replace("savefile", "").replace(".tres", "")
				result.push_back(i)
			file_name = dir.get_next()
	
	return result
