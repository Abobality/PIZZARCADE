extends child

var is_feedable: bool = true;

func _ready() -> void:
	$Timer.start()

func _on_area_entered(area: Area2D) -> void:
	if area is pizza && is_feedable:
		feed();


func _on_timer_timeout() -> void:
	is_feedable = !is_feedable;
	scale.y = -(scale.y);
	monitorable = !monitorable;
