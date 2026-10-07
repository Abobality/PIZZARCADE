extends Area2D

signal pizza_refilled;
var has_ammo = true;

func _on_body_entered(body: Node2D) -> void:
	if body is player and has_ammo:
		pizza_refilled.emit();
		$Icon.visible = false;
		$Timer.one_shot;
		has_ammo = false;


func _on_timer_timeout() -> void:
	$Icon.visible = true;
	has_ammo = true;
