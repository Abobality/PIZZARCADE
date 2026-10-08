extends child

func _on_area_entered(area: Area2D) -> void:
	if area is pizza:
		feed();
