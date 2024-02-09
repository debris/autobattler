extends Resource
class_name Generator

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
	var owned_unit = OwnedUnit.new(unit, rand_schedules())
	return owned_unit

func random_team(units: int) -> Team:
	var team = Team.new()
	for i in units:
		team.members.push_back(random_unit())

	while team.members.size() < 6:
		team.members.push_back(null)
	return team

func random_treasure() -> Treasure:
	var max_index = Treasures.all.size() - 1
	var treasure = Treasures.all[inner.randi_range(0, max_index)]
	var reroll_value = inner.randi_range(1, 99)
	while reroll_value <= treasure.reroll:
		treasure = Treasures.all[inner.randi_range(0, max_index)]
		reroll_value = inner.randi_range(1, 99)
	return treasure

func random_location() -> Location:
	var max_index = Locations.all.size() - 1
	var location = Locations.all[inner.randi_range(0, max_index)]
	var reroll_value = inner.randi_range(1, 99)
	while reroll_value <= location.reroll:
		location = Locations.all[inner.randi_range(0, max_index)]
		reroll_value = inner.randi_range(1, 99)
	return location

func random_map(columns = 5, rows = 5) -> Map:
	var is_row_valid = func(rs, r) -> bool:
		if rs.size() == 0:
			# first row needs to have at least 1 not empty location
			for i in r:
				if !i is LocationEmpty:
					return true
			return false
		for i in rs.back().size():
			if !rs.back()[i] is LocationEmpty:
				# if they location is not empty, check if there are any nodes leading to this location
				var connection = (!r[i] is LocationEmpty) || (i > 0 && !r[i - 1] is LocationEmpty) || (i + 1 < r.size() && !r[i + 1] is LocationEmpty)
				if !connection:
					return false
			else:
				# theck if the node is empty, check if nodes below has something to connect to
				if !r[i] is LocationEmpty:
					var empty = (i == 0 || rs.back()[i - 1] is LocationEmpty) && (i == r.size() - 1 || rs.back()[i + 1] is LocationEmpty)
					if empty:
						return false
				pass
		return true

	var result = Map.new()
	for x in rows:
		var row = []
		
		var is_valid = false
		while !is_valid:
			for y in columns:
				var location = random_location()
				row.push_back(location)
			
			is_valid = is_row_valid.call(result.rows, row)
			if !is_valid:
				row = []

		result.rows.push_back(row)

	return result
