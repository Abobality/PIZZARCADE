extends Area2D
class_name enemy

@export var stun_duration: float = 2.5;
@export var speed: int = 200;

var stun_timer: float = 0.0;
var state: STATES = STATES.MOVE;

enum STATES {MOVE,STUN};

func _physics_process(delta: float) -> void:
	match state:
		STATES.MOVE:
			move_logic(delta);
		STATES.STUN:
			stun_logic(delta)

func move_logic(delta: float):
	pass


func stun_logic(delta: float):
	stun_timer -= delta;
	
	if stun_timer <= 0:
		stun_end();
		
func apply_stun():
	stun_timer = stun_duration;
	
	if state != STATES.STUN:
		state = STATES.STUN;
		stun_start();
		
func stun_start():
	pass
	
func stun_end():
	state = STATES.MOVE;
