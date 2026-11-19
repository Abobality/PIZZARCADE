extends Node2D

func wait_frames(frames: int) -> void:
	for i in range(frames):
		await get_tree().physics_frame

func scale_change(target:Node,xscale1: float,yscale1: float,xscale2: float,yscale2: float,frames: int) -> void:
	if not is_instance_valid(target):
		return
		
	if target.has_meta("juice_scale_tween"):
		var old_tween: Tween = target.get_meta("juice_scale_tween")
		if old_tween and old_tween.is_valid():
			old_tween.kill()
	
	var duration: float = float(frames) / Engine.physics_ticks_per_second
	
	var dir_x := signf(target.scale.x) if target.scale.x != 0 else 1.0
	target.scale = Vector2(absf(xscale1) * dir_x, yscale1)
	
	var tween := target.create_tween()
	target.set_meta("juice_scale_tween", tween)
	var end_scale := Vector2(absf(xscale2) * dir_x, yscale2)
	
	tween.tween_property(target, "scale", end_scale, duration)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
