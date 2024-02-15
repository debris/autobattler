# To indicate that we purposefully do not want character to chave a skill
extends Skill
class_name SkillEmpty

func _init():
	name = "-"
	description = ""

func _execute(query: BattleQuery) -> Array[Log]:
	# use the skill to not accumulate extra casts
	var unit = query.get_this_unit()
	return [LogSkillUsed.new(unit, self)]
