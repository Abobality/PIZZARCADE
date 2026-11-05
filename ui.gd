extends Control

var ammo: int = 0;
var score: int = 0;

func _ready() -> void:
	global_signals.change_ammo.connect(func():change_info_ammo("decrease"))
	global_signals.pizza_refilled.connect(func():change_info_ammo("increase"))
	global_signals.change_level.connect(func():change_info_ammo("new_level"))
	global_signals.score_gain.connect(change_info_score);
	update_ammo_info();
	update_score_info();

func change_info_ammo(type: String):
	match type:
		"increase":
			ammo+=1;
		"decrease":
			ammo-=1;
		"new_level":
			ammo = 0;
			
	update_ammo_info();
	
func change_info_score(scores: int):
	score+=scores;
	update_score_info()
	
func update_ammo_info():
	$HBoxContainer/ammo_show.text = "pizza: %d" % ammo

func update_score_info():
	$HBoxContainer/score_show.text = "score %d" % score

func update_time_info():
	$HBoxContainer/score_show.text = "score %d" % score
