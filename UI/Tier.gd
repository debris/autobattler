extends Label

@export var schedule: Schedule

func _process(_delta):
	if schedule == null:
		text = ""
		return
	text = schedule.tier()
	add_theme_color_override("font_color", GameColors.schedule_color(schedule.kind))
