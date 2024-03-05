extends Control

@onready var grid = $ScrollContainer/Avatars

func avatar_names() -> Array[String]:
	var dir = DirAccess.open("res://Assets/UnitsTransparent")
	var result: Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.contains(".png") && !file_name.contains(".import"):
				result.push_back(file_name)
			file_name = dir.get_next()
	return result

func avatar_path(avatar_name: String) -> String:
	return "res://Assets/UnitsTransparent/" + avatar_name

func _update_grid():
	for child in grid.get_children():
		child.queue_free()
	
	for avatar in avatar_names():
		var avatar_control = load("res://UI/Avatar.tscn").instantiate()
		avatar_control.texture = load(avatar_path(avatar))
		grid.add_child(avatar_control)

func _ready():
	_update_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
