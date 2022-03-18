extends VBoxContainer

onready var score_label = $HBoxContainer/ScoreLabel
var score = Score

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = str(score.current_score)


func _on_Button_button_up():
	get_tree().change_scene("res://MainMenu.tscn")
