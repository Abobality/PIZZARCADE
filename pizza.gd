extends Sprite2D

@export var BULLET_SPEED := 300;
var direction: Vector2 = Vector2.RIGHT
var is_active := false;

func _physics_process(delta: float) -> void:
	position += direction * BULLET_SPEED * delta

func bullet_deactivate():
	global_position = Vector2(0,0);
	visible = false;
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	

func bullet_activate():
	visible = true;
	set_physics_process(true);
	$CollisionShape2D.set_deferred("disabled", false);
