@tool
extends Resource
class_name SchedulePointer

# round number 
@export var round: int
# phase number
@export var phase: int
# set to true if action in schedule is being executed now
@export var active: bool

func _init():
	round = 0
	phase = 0
	active = false
