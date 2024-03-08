extends Control

signal selected(avatar: Avatar)

@onready var grid = $ScrollContainer/Avatars

var selected_index: int = -1

func _update_grid():
	for child in grid.get_children():
		child.queue_free()
	
	for avatar in Avatars.all:
		var avatar_control = load("res://UI/Avatar.tscn").instantiate()
		avatar_control.avatar = avatar
		avatar_control.selected.connect(func(index):
			if selected_index != -1:
				grid.get_child(selected_index).mark_unselected()
			selected_index = index
			selected.emit(avatar)
		)
		grid.add_child(avatar_control)

		if selected_index == -1:
			avatar_control.mark_selected()
			selected_index = 0

func _ready():
	_update_grid()