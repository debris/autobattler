extends Resource
class_name Generator

static var singleton: Generator = Generator.new()

var inner: RandomNumberGenerator

func _init(seed: int = 0):
	inner = RandomNumberGenerator.new()
	inner.seed = seed

func rand_schedule() -> Schedule:
	var fill_n_positions = func(d, n):
		assert(n < d.size())
		for _i in n:
			var position = inner.randi_range(0, d.size() - 1)
			# regenerate positions that are already occupied 
			while d[position] == true:
				position = inner.randi_range(0, d.size() - 1)
			d[position] = true
	
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
	schedule.kind = inner.randi_range(0, 2) as Schedule.Kind
	return schedule

func rand_schedules() -> Array[Schedule]:
	var schedules: Array[Schedule] = [rand_schedule(), rand_schedule(), rand_schedule()]
	# normalize schedule kind so there is always dmg, def and skill
	var direction = (inner.randi_range(0, 1) * 2) - 1
	schedules[1].kind = (schedules[0].kind as int + direction + 3) % 3 as Schedule.Kind
	schedules[2].kind = (schedules[1].kind as int + direction + 3) % 3 as Schedule.Kind
	return schedules
	
func random_unit() -> OwnedUnit:
	var max_index = Units.all.size() - 1 
	var unit = Units.all[inner.randi_range(0, max_index)]
	var owned_unit = OwnedUnit.new()
	owned_unit.base = unit
	owned_unit.dmg = unit.dmg
	owned_unit.def = unit.def
	owned_unit.skill = unit.skill
	owned_unit.schedules = rand_schedules()
	return owned_unit
