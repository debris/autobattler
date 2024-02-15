extends Node

func play_hover():
	_play(preload("res://Assets/Sounds/hover.mp3"))

func play_button_press():
	_play(preload("res://Assets/Sounds/accept.mp3"))

func play_action():
	play_hover()
	
func _play(stream, volume_db: float = 0):
	var player = AudioStreamPlayer.new()
	player.volume_db = volume_db
	add_child(player)
	player.stream = stream
	player.play()
	await player.finished
	player.queue_free()

func start_main_theme_track():
	while true:
		await _play(preload("res://Assets/Sounds/main_theme.mp3"), 9.0)
