extends enemy

func _ready() -> void:
	print(speed)

func move_logic(delta: float):
	if position_mono.player != null:
		global_position.y = move_toward(global_position.y,position_mono.player.global_position.y,speed * delta)
	


func _on_area_entered(area: Area2D) -> void:
	if area is pizza:
		apply_stun();
