extends Resource
class_name Team

@export var members: Array[OwnedUnit]

static func null_team() -> Team:
	var team = Team.new()
	team.members = [null, null, null, null, null, null] as Array[OwnedUnit]
	return team
