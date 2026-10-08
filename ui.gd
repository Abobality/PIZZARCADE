extends Control

var ammo: int = 0;

func _ready() -> void:
	global_signals.change_ammo.connect(func():change_info_ammo("decrease"))
	global_signals.pizza_refilled.connect(func():change_info_ammo("increase"))
	update_ammo_info();

func change_info_ammo(type: String):
	match type:
		"increase":
			ammo+=1;
		"decrease":
			ammo-=1;
			
	update_ammo_info();
	
	
func update_ammo_info():
	$ammo_show.text = "pizza: %d" % ammo
	
