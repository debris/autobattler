# Used for managing Battle UI
extends Object
class_name BattleController

static var singleton

static func default() -> BattleController:
	if singleton == null:
		singleton = BattleController.new()
	return singleton

signal pause
signal play
signal show_details(BattleQuery)
signal show_logs
