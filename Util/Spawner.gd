extends Node2D

export(float) var spawn_interval = 10
export(int) var height
export(int) var width
export(bool) var enabled = true

onready var timer = $Timer

signal on_spawn_timer(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = spawn_interval

func spawn():
	var spawn_pos = Vector2(rand_range(position.x, position.x + width), rand_range(position.y, position.y + height))
	emit_signal("on_spawn_timer", spawn_pos)

func _on_Timer_timeout():
	if (!enabled):
		return
	spawn()
