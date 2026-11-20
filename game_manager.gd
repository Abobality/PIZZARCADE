extends Node2D


enum GAME_STATE{
	NONE,
	PIZZA,
	PLAY,
	END
};


var game_state: GAME_STATE
var time: int = 0;
var pizza: Array[global_names.COMPONENTS] = [];


func _ready() -> void:
	global_signals.game_end.connect(func(): change_state(GAME_STATE.END))
	global_signals.game_start.connect(func(): change_state(GAME_STATE.PLAY))
	change_state(GAME_STATE.PIZZA)

func clear_data():
	if has_node("time_manager"):
		$time_manager.elapsed_ms = 0;
	
func get_pizza_data():
	var pizza_node = $CanvasLayer.get_node_or_null("pizza_maker")
	if pizza_node:
		pizza = pizza_node.pizza
		print("Recipe: ", pizza)
	else:
		print("error: pizza_maker not found in CanvasLayer")
	
func set_pizza_data():
	global_names.global_pizza = pizza

func get_time_data():
	if has_node("time_manager"):
		time = $time_manager.elapsed_ms
		print(time)
	else:
		print("error")
	
func set_time_data(_scene):
	_scene.time_result = time;
	
func change_screen_to_pizza():
	var pizza_maker = preload("res://pizza_maker.tscn");
	var scene = pizza_maker.instantiate()
	$CanvasLayer.add_child(scene)
	
func change_screen_to_game():
	var pizza_node = $CanvasLayer.get_node_or_null("pizza_maker")
	get_pizza_data()
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
	get_time_data();
	set_time_data(scene);
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
	
	game_state = new_state;
	
	match game_state:
		GAME_STATE.PIZZA:
			change_screen_to_pizza();
		GAME_STATE.PLAY:
			change_screen_to_game();
		GAME_STATE.END:
			change_screen_to_win();

#Cheats
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N: 
			global_signals.change_level.emit();
		if event.keycode == KEY_Q: 
			global_signals.game_end.emit();
