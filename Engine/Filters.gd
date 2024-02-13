extends Object
class_name Filters

static func phase_skill(battle_query: BattleQuery):
	return func(battle_unit):
		var schedule = battle_unit.schedules[battle_query.get_phase()]
		return schedule.is_skill() && schedule.at(battle_query.get_round())

static func phase_defence(battle_query: BattleQuery):
	return func(battle_unit):
		var schedule = battle_unit.schedules[battle_query.get_phase()]
		return schedule.is_defence() && schedule.at(battle_query.get_round())

static func this_unit(unit: BattleUnit):
	return func(battle_unit):
		return battle_unit.get_instance_id() == unit.get_instance_id()

static func not_this_unit(unit: BattleUnit):
	return func(battle_unit):
		return battle_unit.get_instance_id() != unit.get_instance_id()

static func tag(t: String):
	return func(battle_unit):
		return battle_unit.tags.has(t)

static func any_tag(tags: Array[String]):
	return func(battle_unit):
		for t in tags: 
			if battle_unit.tags.has(t):
				return true
		return false

static func no_tag(t: String):
	return func(battle_unit):
		return !battle_unit.tags.has(t)

static func passive(passive_type):
	return func(battle_unit):
		return is_instance_of(battle_unit.unit.base.passive, passive_type)
