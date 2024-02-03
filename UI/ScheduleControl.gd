@tool
extends Control
class_name ScheduleControl

@export var schedule: Schedule
@export var schedule_pointer: SchedulePointer

var active = false

func _process(_delta):
	if schedule_pointer != null && schedule_pointer.active != active:
		active = schedule_pointer.active
		queue_redraw()

func _draw():
	const cells = 8
	const background_color = Color.DIM_GRAY
	const frame_color = Color.BLACK
	const positive_color = Color.DARK_GREEN
	const active_color = Color.RED
	
	var cell_x = size.x / cells
	var cell_y = size.y
	var cell_size = Vector2(cell_x, cell_y)

	# for testing the layout
	var schedule_size = 8
	if schedule != null:
		schedule_size = schedule.data.size()
	
	# draw background
	draw_rect(Rect2(Vector2.ZERO, Vector2(cell_x * schedule_size, cell_y)), background_color, true)

	for i in schedule_size:
		if schedule != null && schedule.at(i):
			draw_rect(Rect2(Vector2(cell_x * i, 0), cell_size), positive_color, true)
			
			if schedule_pointer != null && schedule_pointer.active:
				if i == schedule.normalize(schedule_pointer.round):
					draw_rect(Rect2(Vector2(cell_x * i, 0), cell_size), active_color, true)
		
		# draw cell frames
		draw_rect(Rect2(Vector2(cell_x * i, 0), cell_size), frame_color, false, 2.0)
