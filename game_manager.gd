extends Node2D

var game_state = GAME_STATE.PLAY

enum GAME_STATE{
	PLAY,
	VICTORY
};

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	match game_state:
		GAME_STATE.PLAY:
			pass;
		GAME_STATE.VICTORY:
			pass;

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_N: 
			global_signals.change_level.emit();
