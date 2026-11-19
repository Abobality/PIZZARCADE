extends Node2D

func wait_frames(frames: int) -> void:
	for i in range(frames):
		await get_tree().physics_frame

func scale_change(target:Node,xscale1: float,yscale1: float,xscale2: float,yscale2: float,seconds: float) -> void:
	var dir_x := signf(target.scale.x) if target.scale.x != 0 else 1.0
	target.scale = Vector2(absf(xscale1) * dir_x, yscale1)
	
	var tween := target.create_tween()
	var end_scale := Vector2(absf(xscale2) * dir_x, yscale2)
	
	tween.tween_property(target, "scale", end_scale, seconds)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
