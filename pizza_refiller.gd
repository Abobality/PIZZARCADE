extends Area2D

var has_ammo = true;

func _on_body_entered(body: Node2D) -> void:
	if body is player and has_ammo:
		juice.scale_change($Sprite2D, 6.5, 3.5, 5.0, 5.0, 10)
		await juice.wait_frames(6)
		collect_pizza()


func _on_timer_timeout() -> void:
	$Sprite2D.visible = true;
	juice.scale_change($Sprite2D, 7.5, 3.5, 5.0, 5.0, 10)
	has_ammo = true;
	
	for body in get_overlapping_bodies():
		if body is player:
			juice.scale_change($Sprite2D, 7.5, 3.5, 5.0, 5.0, 10)
			await juice.wait_frames(6)
			collect_pizza()
			break


func collect_pizza() -> void:
	global_signals.pizza_refilled.emit()
	$Sprite2D.visible = false
	$Timer.start()
	has_ammo = false
