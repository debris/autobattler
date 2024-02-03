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
	const cell_offset = Vector2(1, 1)
	const background_color = Color.TRANSPARENT #Color(Color.DIM_GRAY, 0.5)
	const frame_color = Color.TRANSPARENT #Color.BLACK
	const positive_color = Color(Color.DARK_GREEN, 0.4)
	const negative_color = Color(Color.DIM_GRAY, 0.4)
	const active_color = Color(Color.RED, 0.4)
	const waiting_color = Color(Color.YELLOW, 0.4)
	const line_color = Color(Color.DIM_GRAY, 1.0)
	
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
		if schedule != null:
			if schedule.at(i):
				draw_rect(Rect2(Vector2(cell_x * i, 0) + cell_offset, cell_size - cell_offset * 2), positive_color, true)
			else:
				draw_rect(Rect2(Vector2(cell_x * i, 0) + cell_offset, cell_size - cell_offset * 2), negative_color, true)
			
			if schedule_pointer != null && i == schedule.normalize(schedule_pointer.round):
				if schedule_pointer.active:
					# draw currently executed cell
					draw_rect(Rect2(Vector2(cell_x * i, 0) + cell_offset, cell_size - cell_offset * 2), active_color, true)
				else:
					# draw next vell that will be executed
					draw_rect(Rect2(Vector2(cell_x * i, 0), Vector2(2, cell_y)), waiting_color, true)
		
		# draw cell frames
		draw_rect(Rect2(Vector2(cell_x * i, 0), cell_size), frame_color, false, 2.0)
	
	#draw_line(Vector2.ZERO, Vector2(cell_x * schedule_size, 0), line_color, 0.5, true)
