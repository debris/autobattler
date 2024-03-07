extends Control

const SPEED_1 = 1.0
const SPEED_2 = 0.55
const SPEED_3 = 0.1

signal play
signal pause
signal step

func _on_speed_1_pressed():
	_set_speed(SPEED_1)

func _on_speed_2_pressed():
	_set_speed(SPEED_2)

func _on_speed_3_pressed():
	_set_speed(SPEED_3)

func _set_speed(speed: float):
	var settings = DisplaySettings.default()
	settings.step_time = speed
	play.emit()

func _on_pause_pressed():
	pause.emit()

func _on_step_pressed():
	step.emit()
