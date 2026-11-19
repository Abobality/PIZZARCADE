extends Node2D


enum GAME_STATE{
	PIZZA,
	PLAY,
	END
};

var game_state = GAME_STATE.PIZZA
var time: int = 0;


func _ready() -> void:
	global_signals.game_end.connect(func(): change_state(GAME_STATE.END))
	


	
func get_data():
	if has_node("time_manager"):
		time = $time_manager.elapsed_ms
		print(time)
	else:
		print("error")
	
func set_data(_scene):
	_scene.time_result = time;
	
func change_screen_to_pizza():
	var pizza_maker = preload("res://pizza_maker.tscn");
	var scene = pizza_maker.instantiate()
	$CanvasLayer.add_child(scene)
	
func change_screen_to_game():
	var pizza_node = $CanvasLayer.get_node_or_null("pizza_maker")
	if pizza_node:
		pizza_node.queue_free()
	var UI = preload("res://UI.tscn");
	var scene = UI.instantiate()
	$CanvasLayer.add_child(scene)
	$time_manager.visible=true;
	$level_manager.visible=true;
	$score_counter.visible=true;
	

func change_screen_to_win():
	var win_scene = preload("res://win_screen.tscn");
	var scene = win_scene.instantiate()
	var UI_node = $CanvasLayer.get_node_or_null("Control")
	set_data(scene);
	$time_manager.visible=false;
	$level_manager.visible=false;
	$score_counter.visible=false;
	if UI_node:
		UI_node.queue_free();
	await get_tree().process_frame
	add_child(scene);
	

#State machine
func change_state(new_state: GAME_STATE):
	if game_state == new_state:
		return;
	
	match game_state:
		GAME_STATE.PIZZA:
			pass;
		GAME_STATE.PLAY:
			pass;
		GAME_STATE.END:
			pass;

#Cheats
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N: 
			global_signals.change_level.emit();
		if event.keycode == KEY_Q: 
			global_signals.game_end.emit();
