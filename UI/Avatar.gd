extends Control

signal selected(index)

@export var texture: Texture2D:
	set(value):
		texture = value
		if is_node_ready():
			_update_avatar()

@onready var texture_rect = $TextureRect
@onready var on_hover = $OnHover
@onready var on_select = $OnSelect

func _update_avatar():
	texture_rect.texture = texture

func _ready():
	_update_avatar()

	mouse_entered.connect(func():
		Sounds.play_hover()
		on_hover.visible = true
	)

	mouse_exited.connect(func():
		on_hover.visible = false
	)

func mark_unselected():
	on_select.visible = false

func _gui_input(event):
	if !on_select.visible && event.is_action_pressed("LeftClick"):
		var mouse_position = get_global_mouse_position()
		var rect = get_global_rect()
		if rect.has_point(mouse_position):
			Sounds.play_button_press()
			mark_selected()

func mark_selected():
	on_select.visible = true
	selected.emit(get_index())