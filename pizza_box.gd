extends Node2D

var pizzaNumber: int;

func _ready() -> void:
	global_signals.change_ammo.connect(func():change_info_ammo("decrease"))
	global_signals.pizza_refilled.connect(func():change_info_ammo("increase"))
	update_stack_visual()


func change_info_ammo(type: String):
	match type:
		"increase":
			pizzaNumber+=1;
		"decrease":
			pizzaNumber-=1;
		"new_level":
			pizzaNumber = 0;

	update_stack_visual()

func update_stack_visual() -> void:
	for i in range(get_child_count()):
		var pizza_sprite := get_child(i)
		pizza_sprite.visible = i < pizzaNumber
