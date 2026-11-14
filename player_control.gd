extends CharacterBody2D
class_name player

@export var SPEED := 300;
@onready var animation_player = $AnimationPlayer;

var AMMO := 0;
var state = STATES.IDLE;

enum STATES{
	IDLE,
	IDLE_PIZZA,
	MOVE,
	MOVE_PIZZA
}

const PIZZA = preload("res://pizza.tscn");

func _ready() -> void:
	global_signals.pizza_refilled.connect(pizza_refill);
	position_mono.player = self;
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play("idle")

func _exit_tree() -> void:
	if position_mono.player == self:
		position_mono.player = null;

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	match state:
		STATES.IDLE:
			idlyng();
		STATES.IDLE_PIZZA:
			pass;
		STATES.MOVE:
			pass;
		STATES.MOVE_PIZZA:
			pass;
	
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
	
func idlyng():
	var __chance = 1;
	animation_player.play("idle")
	if animation_player.animation_finished:
		__chance = randi_range(1,100);
		print("chance: %d" %__chance)
		if __chance <= 33:
			animation_player.play("idle_blink");
		else:
			animation_player.play("idle");


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
