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
signal move_unit_left(unit_index: int)
signal move_unit_right(unit_index: int)
signal change_pressed(unit_index: int)
