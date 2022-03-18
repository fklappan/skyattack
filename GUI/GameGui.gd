extends VBoxContainer

var score = Score
var stats = PlayerStats
onready var score_label = $MarginContainer/HBoxContainer/Score
onready var texture_progress = $HBoxContainer/TextureProgress
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("GameGui ready")
	score.connect("score_changed", self, "on_score_changed")
	stats.connect("max_health_changed", self, "on_max_health_changed")
	stats.connect("health_changed", self, "on_health_changed")
	on_max_health_changed(stats.max_health)


func on_score_changed(score):
	score_label.text = str(score)
	
func on_max_health_changed(health):
	texture_progress.max_value = health
	texture_progress.value = health
	
func on_health_changed(health):
	texture_progress.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
