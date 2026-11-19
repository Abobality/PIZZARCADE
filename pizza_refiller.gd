extends Area2D

var has_ammo = true;

func _on_body_entered(body: Node2D) -> void:
	if body is player and has_ammo:
		collect_pizza()


func _on_timer_timeout() -> void:
	$Sprite2D.visible = true;
	has_ammo = true;
	
	for body in get_overlapping_bodies():
		if body is player:
			collect_pizza()
			break


func collect_pizza() -> void:
	global_signals.pizza_refilled.emit()
	$Sprite2D.visible = false
	$Timer.start()
	has_ammo = false
