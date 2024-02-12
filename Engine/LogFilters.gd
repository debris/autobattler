extends Object
class_name LogFilters

static func type(log_type):
	return func(pl: ProcessedLog):
		return is_instance_of(pl.get_value(), log_type)

static func not_type(log_type):
	return func(pl: ProcessedLog):
		return !is_instance_of(pl.get_value(), log_type)
		
static func passive_type(passive_type):
	return func(pl: ProcessedLog):
		return is_instance_of(pl.get_value().unit.unit.base.passive, passive_type)

static func tag(tag: String):
	return func(pl: ProcessedLog):
		return pl.get_value().unit.tags.has(tag)

static func enemy_team_stacks_not_zero(kind: Stacks.Kind):
	return func(pl: ProcessedLog):
		return pl.query().get_enemy_team().stacks.get_value(kind) > 0

static func round_greater_than(number):
	return func(pl: ProcessedLog):
		return pl.query().get_round() > number
