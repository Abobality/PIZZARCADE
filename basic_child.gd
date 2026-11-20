extends child

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
var state;

enum STATES{
	NONE,
	IDLE,
	EAT
}

func _ready() -> void:
	randomize()
	state = STATES.IDLE;
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play("idle")

func _on_area_entered(area: Area2D) -> void:
	if area is pizza:
		feed();

func _on_animation_finished(anim_name: String) -> void:
	match state:
		STATES.IDLE:
			animation_blink_player(anim_name,"idle","idle_blink")
		STATES.EAT:
			animation_player.play("idle")
			state = STATES.IDLE

func animation_blink_player(anim_name,basic_idle,blink_idle):
	if anim_name == basic_idle:
		var chance := randi_range(1, 100)
		if chance <= 20:
			animation_player.play(blink_idle)
		else:
			animation_player.play(basic_idle)
	else: 
		animation_player.play(basic_idle)

func feed() -> void:
	if hungry <= 0:
		return
	state = STATES.EAT
	animation_player.play("eat")
	super.feed() 

func _on_full() -> void:
	await juice.wait_frames(5)
	super._on_full()
