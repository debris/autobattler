extends Node

var settings: DisplaySettings

var music_player: AudioStreamPlayer:
	set(value):
		music_player = value
		if music_player != null:
			_check_if_music_should_be_played()

func _ready():
	settings = DisplaySettings.default()
	settings.music_on_changed.connect(_check_if_music_should_be_played)

func _check_if_music_should_be_played():
	music_player.stream_paused = !settings.music_on

func play_hover():
	if settings.sounds_on:
		_play(preload("res://Assets/Sounds/hover.mp3"))

func play_button_press():
	if settings.sounds_on:
		_play(preload("res://Assets/Sounds/accept.mp3"))

func play_action():
	if settings.sounds_on:
		play_hover()
	
func _play(stream, property: String = "", volume_db: float = 0):
	var player = AudioStreamPlayer.new()
	player.volume_db = volume_db
	add_child(player)
	player.stream = stream
	player.play()
	if property != "":
		self[property] = player
	await player.finished
	player.queue_free()

func start_main_theme_track():
	while true:
		await _play(preload("res://Assets/Sounds/main_theme.mp3"), "music_player", 9.0)
	
