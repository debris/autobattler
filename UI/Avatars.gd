extends Control

signal selected(avatar: Texture2D)

@onready var grid = $ScrollContainer/Avatars

var selected_index: int = -1

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
		avatar_control.selected.connect(func(index):
			if selected_index != -1:
				grid.get_child(selected_index).mark_unselected()
			selected_index = index
			selected.emit(avatar_control.texture)
		)
		grid.add_child(avatar_control)

		if selected_index == -1:
			avatar_control.mark_selected()
			selected_index = 0

func _ready():
	_update_grid()