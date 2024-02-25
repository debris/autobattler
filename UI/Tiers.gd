extends Control

@export var schedules: Array[Schedule]

@onready var grid = $GridContainer

func _process(_delta):
	if schedules.size() > 0:
		for i in 3:
			grid.get_child(i).schedule = schedules[i]
