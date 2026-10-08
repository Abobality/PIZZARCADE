extends Area2D
class_name enemy

@export var stun_timer: float = 2.5;
@export var speed: int = 200;
var is_stunned: bool = false;

func _ready() -> void:
	$Timer.wait_time = stun_timer;
	
func _process(delta: float) -> void:
	global_position.y = move_toward(global_position.y, target.global_position.y, speed * delta)

func stun():
	return
	
	
