extends Node

func play_hover():
	_play(preload("res://Assets/Sounds/hover.mp3"))

func play_button_press():
	_play(preload("res://Assets/Sounds/accept.mp3"))

func play_action():
	play_hover()
	
func _play(stream):
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = stream
	player.play()
	await player.finished
	player.queue_free()
