extends ColorRect

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.speed_scale = 1.0 / DisplaySettings.default().screen_transition_time
