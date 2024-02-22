extends Control

signal finished

@export var dialog: Dialog:
	set(value):
		dialog = value;
		current_chapter = -1
		if is_node_ready():
			animation_player.stop(false)
			_update_avatar()

@onready var typing_label = $ColorRect/TypingLabel
@onready var avatar = $ColorRect/Avatar
@onready var animation_player = $AnimationPlayer

var characters_per_second: float = 20.0
var current_chapter = -1

func _ready():
	_update_avatar()

func _update_avatar():
	avatar.texture = dialog.avatar

func _gui_input(event):
	if event.is_action_pressed("LeftClick") || Input.is_action_just_pressed("ui_accept"):
		accept_event()
		next_chapter()

func next_chapter():
	if animation_player.is_playing():
		animation_player.stop(true)
		typing_label.percent = 1.0
		return
	
	current_chapter += 1
	
	if current_chapter == dialog.chapters.size():
		queue_free()
		finished.emit()
		return
	elif current_chapter > dialog.chapters.size():
		return

	typing_label.percent = 0.0
	typing_label.final_text = dialog.chapters[current_chapter]
	animation_player.speed_scale = characters_per_second / dialog.chapters[current_chapter].length()
	animation_player.play("typing")
