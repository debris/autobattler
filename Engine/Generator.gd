extends Resource
class_name Generator

static var singleton: Generator = Generator.new()

var inner: RandomNumberGenerator

func _init(seed: int = 0):
	inner = RandomNumberGenerator.new()
	inner.seed = seed

func rand_schedule() -> Schedule:
	var fill_n_positions = func(data, n):
		assert(n < data.size())
		for _i in n:
			var position = inner.randi_range(0, data.size() - 1)
			# regenerate positions that are already occupied 
			while data[position] == true:
				position = inner.randi_range(0, data.size() - 1)
			data[position] = true
	
	var length = inner.randi_range(3, 8)
	var data: Array[bool] = []
	for _i in length:
		data.push_back(false)
		
	if length == 3 || length == 4:
		fill_n_positions.call(data, 1)
	elif length == 5 || length == 6: 
		fill_n_positions.call(data, 2)
	else:
		fill_n_positions.call(data, 3)

	var schedule = Schedule.new()
	schedule.data = data
	return schedule
