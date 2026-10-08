extends Area2D
class_name pizza

@export var BULLET_SPEED := 300;
@export var LIFE_TIME := 2.0;
var direction: Vector2 = Vector2.RIGHT
var is_active := false;
var current_life_timer := 0.0;

func _physics_process(delta: float) -> void:
	position += direction * BULLET_SPEED * delta
	
	current_life_timer+=delta;
	
	if current_life_timer >= LIFE_TIME:
		bullet_pool_manager.return_bullet(self)

func bullet_deactivate():
	global_position = Vector2(0,0);
	visible = false;
	current_life_timer = 0.0;
	set_physics_process(false);
	$CollisionShape2D.set_deferred("disabled", true);
	

func bullet_activate(spawn_position,shoot_direction):
	global_position = spawn_position;
	direction = shoot_direction;
	visible = true;
	set_physics_process(true);
	$CollisionShape2D.set_deferred("disabled", false);
	

func _on_area_entered(area: Area2D) -> void:
	if area is child:
		bullet_pool_manager.return_bullet(self)
