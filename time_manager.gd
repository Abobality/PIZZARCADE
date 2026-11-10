extends Node2D

var start_time: int = 0;
var elapsed_ms: int = 0;
var is_running: bool = false;

func _ready() -> void:
	global_signals.game_start.connect(start_timer);
	global_signals.game_end.connect(stop_timer);

func start_timer():
	start_time = Time.get_ticks_msec();
	is_running = true;
	print("timer on")
	
func stop_timer():
	if is_running:
		elapsed_ms = Time.get_ticks_msec() - start_time; 
		is_running = false;
	return elapsed_ms;
