@tool
extends Resource
class_name SchedulePointer

# battle_round number 
@export var battle_round: int
# phase number
@export var phase: int
# set to true if action in schedule is being executed now
@export var active: bool

func _init():
	battle_round = 0
	phase = 0
	active = false
