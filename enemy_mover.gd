extends enemy

func move_logic(delta: float):
	if position_mono.player != null:
		global_position.y = move_toward(global_position.y,position_mono.player.y,speed * delta)
	
