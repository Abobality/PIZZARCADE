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
			
func victory():
	game_state = GAME_STATE.VICTORY;
	get_data();
	game_state = GAME_STATE.END;
	await change_screen_to_win();
	
	
func get_data():
	if has_node("time_manager"):
		time = $time_manager.elapsed_ms
	
func set_data(scene):
	if has_node(scene):
		scene.time_result = time;
	

func change_screen_to_win():
	$CanvasLayer.queue_free();
	$time_manager.queue_free();
	$level_manager.queue_free();
	$score_counter.queue_free();
	await get_tree().process_frame
	var win_scene = preload("res://win_screen.tscn");
	var scene = win_scene.instantiate()
	add_child(scene);
	set_data(scene);
