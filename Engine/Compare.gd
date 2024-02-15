extends Object
class_name Compare

static func highest_def(unit_a: BattleUnit, unit_b: BattleUnit):
	if unit_a.def >= unit_b.def:
		return unit_a
	return unit_b

static func lowest_def(unit_a: BattleUnit, unit_b: BattleUnit):
	if unit_a.def <= unit_b.def:
		return unit_a
	return unit_b

static func highest_dmg(unit_a: BattleUnit, unit_b: BattleUnit):
	if unit_a.dmg >= unit_b.dmg:
		return unit_a
	return unit_b
