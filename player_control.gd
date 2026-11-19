extends CharacterBody2D
class_name player

@export var SPEED := 300;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;

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
	
	if direction != Vector2.ZERO:
		change_state(STATES.MOVE_PIZZA if AMMO > 0 else STATES.MOVE)
		velocity = direction * SPEED
	else:
		change_state(STATES.IDLE_PIZZA if AMMO > 0 else STATES.IDLE)
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
	
	if direction:
		velocity = direction * SPEED;
	else:
		velocity = velocity.move_toward(Vector2.ZERO,SPEED);
		
	move_and_slide()
	
	if Input.is_action_just_released("ui_shoot"):
		shoot();
	
	if direction.x < 0 or (direction.x == 0 and direction.y < 0):
		$Sprite2D.scale.x = -5
	elif direction != Vector2.ZERO:
		$Sprite2D.scale.x = 5
		

func shoot() -> void:
	if AMMO > 0:
		bullet_pool_manager.shoot(Vector2(global_position.x + 64,global_position.y),Vector2.RIGHT)
		AMMO-=1;
		global_signals.change_ammo.emit()

func pizza_refill():
	AMMO+=1;
	

func _on_animation_finished(anim_name: String) -> void:
	if state == STATES.IDLE:
		idlyng(anim_name,"idle","idle_blink")
	elif state == STATES.IDLE_PIZZA:
		idlyng(anim_name,"idle_pizza","idle_blink_pizza")
	

func idlyng(anim_name,basic_idle,blink_idle):
	if anim_name == basic_idle:
		var chance := randi_range(1, 100)
		if chance <= 20:
			animation_player.play(blink_idle)
		else:
			animation_player.play(basic_idle)
	else: 
		animation_player.play(basic_idle)

func change_state(new_state: STATES) -> void:
	if state == new_state:
		return 
		
	state = new_state
	
	match state:
		STATES.IDLE:
			animation_player.play("idle")
		STATES.IDLE_PIZZA:
			animation_player.play("idle_pizza")
		STATES.MOVE:
			pass
		STATES.MOVE_PIZZA:
			pass
