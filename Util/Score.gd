extends Node

var current_score = 0 

signal score_changed(score)

func add_score(score):
	current_score += score
	emit_signal("score_changed", current_score)
