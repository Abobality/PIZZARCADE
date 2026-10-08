extends CharacterBody2D
class_name player

@export var SPEED := 300;
var AMMO := 0;

const PIZZA = preload("res://pizza.tscn");

func _ready() -> void:
	global_signals.pizza_refilled.connect(pizza_refill)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction:
		velocity = direction * SPEED;
	else:
		velocity = velocity.move_toward(Vector2.ZERO,SPEED);
		
	move_and_slide()
	
	if Input.is_action_just_released("ui_shoot"):
		shoot();

func shoot() -> void:
	if AMMO > 0:
		bullet_pool_manager.shoot(Vector2(global_position.x + 64,global_position.y),Vector2.RIGHT)
		AMMO-=1;
		global_signals.change_ammo.emit()

func pizza_refill():
	AMMO+=1;
