extends Area2D
class_name child

@export var hungry: int = 3;

var _can_eat := true

func feed() -> void:
	if hungry <= 0 or not _can_eat:
		return
	_can_eat = false
	hungry -= 1
	
	if hungry <= 0:
		_on_full()
	else:
		await get_tree().physics_frame
		_can_eat = true


func _on_full() -> void:
	global_signals.score_gain.emit(100)
	queue_free()
