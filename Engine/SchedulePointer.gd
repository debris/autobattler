extends Resource
class_name SchedulePointer

# round number 
var round: int
# phase number
var phase: int
# set to true if action in schedule is being executed now
var active: bool

func _init():
	round = 0
	phase = 0
	active = false
