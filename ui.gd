extends Control

var ammo: int = 0;
var score: int = 0;
var start_time: int = 0;
var elapsed_ms: int = 0;
var is_running: bool = false;

func _ready() -> void:
	global_signals.game_start.connect(start_timer);
	global_signals.game_end.connect(stop_timer);
	global_signals.change_ammo.connect(func():change_info_ammo("decrease"))
	global_signals.pizza_refilled.connect(func():change_info_ammo("increase"))
	global_signals.change_level.connect(func():change_info_ammo("new_level"))
	global_signals.score_gain.connect(change_info_score)
	print(global_signals.game_start.is_connected(start_timer))
	
	update_ammo_info();
	update_score_info();

func _process(_delta: float) -> void:
	if is_running:
		update_time_info();

func change_info_ammo(type: String):
	match type:
		"increase":
			ammo+=1;
		"decrease":
			ammo-=1;
		"new_level":
			ammo = 0;
			
	update_ammo_info();
	
func start_timer():
	start_time = Time.get_ticks_msec();
	is_running = true;
	print("timer on")
	
func stop_timer():
	is_running = false;
	return elapsed_ms;
	

	
func change_info_score(scores: int):
	score+=scores;
	update_score_info()
	
func update_ammo_info():
	$HBoxContainer/ammo_show.text = "pizza: %d" % ammo

func update_score_info():
	$HBoxContainer/score_show.text = "score %d" % score

func update_time_info():
	elapsed_ms = Time.get_ticks_msec() - start_time;
	$HBoxContainer/time_show.text = "time: %s" %format_time(elapsed_ms);

func format_time(ms:int):
	var total_seconds = ms/1000;
	var minutes = ms / 60000
	var seconds = (ms % 60000) / 1000
	var miliseconds = ms % 1000
	return "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
