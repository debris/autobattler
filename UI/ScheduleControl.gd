@tool
extends Control
class_name ScheduleControl

@export var phase: int = 0:
	set(value):
		if value != phase:
			phase = value
			queue_redraw()

@export var schedule: Schedule:
	set(value):
		if value != schedule:
			schedule = value
			queue_redraw()

@export var schedule_pointer: SchedulePointer = SchedulePointer.new():
	set(value):
		if value != schedule_pointer:
			schedule_pointer = value
			queue_redraw()

var the_color: Color = Color.DIM_GRAY

var drawn_round = 0
var drawn_phase = 0
var drawn_active = false


func _process(_delta):
	# we cannot redraw all the time cause the game may freeze
	# this limits the amount of redraws
	if schedule_pointer != null:
		if schedule_pointer.active != drawn_active || schedule_pointer.battle_round != drawn_round || schedule_pointer.phase != drawn_phase:
			queue_redraw()

func _draw():
	if schedule_pointer != null:
		drawn_active = schedule_pointer.active
		drawn_round = schedule_pointer.battle_round
		drawn_phase = schedule_pointer.phase
	
	if schedule != null:
		the_color = GameColors.schedule_color(schedule.kind)
	
	const cells = 8
	const cell_offset = Vector2(1, 1)
	const background_color = Color.TRANSPARENT #Color(Color.DIM_GRAY, 0.5)
	const frame_color = Color.TRANSPARENT #Color.BLACK
	const negative_color = Color(Color.GRAY, 0.3)
	#var active_color = Color(Color.DIM_GRAY, 0.4) #Color(Color.RED, 0.4)
	var active_color = Color.YELLOW
	var waiting_color = Color.TRANSPARENT #Color(Color.DIM_GRAY, 0.4)
	#const line_color = Color(Color.DIM_GRAY, 1.0)
	var positive_color = Color(the_color, 0.7) #Color(Color.DARK_GREEN, 0.4)
	
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
			
			if schedule_pointer != null && i == schedule.normalize(schedule_pointer.battle_round):
				if schedule_pointer.active && schedule_pointer.phase == phase:
					# draw currently executed cell
					draw_rect(Rect2(Vector2(cell_x * i, 0) + cell_offset, cell_size - cell_offset * 2), active_color, true)
				else:
					# draw next cell that will be executed
					draw_rect(Rect2(Vector2(cell_x * i, cell_offset.y), Vector2(0.5, cell_y - cell_offset.y * 2)), waiting_color, true)
		
		# draw cell frames
		draw_rect(Rect2(Vector2(cell_x * i, 0), cell_size), frame_color, false, 2.0)
	
	#draw_line(Vector2.ZERO, Vector2(cell_x * schedule_size, 0), line_color, 0.5, true)
