extends Resource
class_name SchedulePointer

# round number 
var round: int
# set to true if action in schedule is being executed now
var active: bool

func _init():
	round = 0
	active = false
