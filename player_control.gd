extends CharacterBody2D

@export var SPEED := 300;
@export var AMMO := 6;

const PIZZA = preload("res://pizza.tscn");

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
		var bullet = PIZZA.instantiate();
		bullet.global_position = global_position;
		get_tree().current_scene.add_child(bullet);
		AMMO-=1;
