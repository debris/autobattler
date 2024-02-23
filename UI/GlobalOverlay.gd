extends CanvasLayer
class_name GlobalOverlay

static var on_exit: Callable
static var on_team_pressed: Callable
static var goto_loadgame: Callable

@onready var exit_button = $Panel/ExitButton
@onready var settings_button = $Panel/SettingsButton
@onready var help_button = $Panel/HelpButton
@onready var team_button = $Panel/TeamButton
@onready var logs_button = $Panel/LogsButton

var subview: Control

func present_subview(view):
	if subview != null:
		subview.queue_free()
		# hacky way for toggling subviews
		if subview.get_script().get_instance_id() == view.get_script().get_instance_id():
			return
	
	add_child(view)
	move_child(view, 1)
	subview = view

func _on_settings_button_pressed():
	var settings =  preload("res://UI/Settings.tscn").instantiate()
	present_subview(settings)

func _on_help_button_pressed():
	var help =  preload("res://UI/Help.tscn").instantiate()
	present_subview(help)

func _on_exit_button_pressed():
	if subview != null:
		subview.queue_free()
		return
	
	var exit = preload("res://UI/Question.tscn").instantiate()
	exit.question_text = tr("EXIT_TO_MAIN_MENU")
	exit.yes_pressed.connect(func(): 
		on_exit.call()
	)
	exit.cancel_pressed.connect(func():
		exit.queue_free()
	)	
	present_subview(exit)
	

func _on_team_button_pressed():
	on_team_pressed.call(self)

func _on_logs_button_pressed():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Escape"):
		exit_button.accept_event()
		_on_exit_button_pressed()
