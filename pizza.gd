extends Sprite2D

@export var BULLET_SPEED := 300;
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction * BULLET_SPEED * delta
