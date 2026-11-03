extends Node2D

var score: int = 0;
var child_count: int = 0;
var current_score: int = 0;

func _ready() -> void:
	global_signals.score_gain.connect(score_plus)
	count_children();
	

func score_plus(_score: int):
	score += _score;
	current_score += _score;

func count_children():
	var count = get_tree().get_nodes_in_group("children").size()
	print("Количество сцен в группе: ", count)
	child_count = count;
