extends Node2D

var game_state = GAME_STATE.PLAY
var time: int = 0;

enum GAME_STATE{
	PLAY,
	VICTORY,
	END
};

func _ready() -> void:
	global_signals.game_end.connect(victory)
	
func _process(_delta: float) -> void:
	match game_state:
		GAME_STATE.PLAY:
			pass;
		GAME_STATE.VICTORY:
			pass;
		GAME_STATE.END:
			pass;

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N: 
			global_signals.change_level.emit();
		if event.keycode == KEY_Q: 
			global_signals.game_end.emit();
			
func victory():
	game_state = GAME_STATE.VICTORY;
	get_data();
	game_state = GAME_STATE.END;
	await change_screen_to_win();
	
	
func get_data():
	if has_node("time_manager"):
		time = $time_manager.elapsed_ms
		print(time)
	else:
		print("error")
	
func set_data(_scene):
	_scene.time_result = time;
	

func change_screen_to_win():
	var win_scene = preload("res://win_screen.tscn");
	var scene = win_scene.instantiate()
	set_data(scene);
	$time_manager.queue_free();
	$level_manager.queue_free();
	$score_counter.queue_free();
	$CanvasLayer.queue_free();
	await get_tree().process_frame
	add_child(scene);
	
