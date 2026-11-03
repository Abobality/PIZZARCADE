extends Node2D

var score: int = 0;

func _ready() -> void:
	global_signals.score_gain.connect(score_plus)
	

func score_plus(_score: int):
	score += _score;
