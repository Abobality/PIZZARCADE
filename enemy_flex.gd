extends enemy

@export var MIN: float;
@export var MAX: float;

var time: float = 0.0;
var amplitude: float;
var center_offset: float;

func _ready() -> void:
	amplitude = (MAX - MIN) / 2.0;
	center_offset = (MAX + MIN) / 2.0;

func move_logic(delta: float):
	time += delta * speed;
	var new_coord = center_offset + sin(time) * amplitude;
	global_position.y = new_coord;

func _on_area_entered(area: Area2D) -> void:
	if area is pizza:
		apply_stun();
