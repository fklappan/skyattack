extends Node2D

export(int) var movement_range = 40

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_target_position()
	start_timer()
	
func start_timer():
	timer.start(rand_range(0.1, 2))

func update_target_position():
	var target_vec = Vector2(rand_range(-movement_range, movement_range), rand_range(-movement_range, movement_range))
	target_position = start_position + target_vec

func _on_Timer_timeout():
	update_target_position()
	start_timer()
