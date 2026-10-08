extends Control

var ammo;

func _ready() -> void:
	global_signals.change_ammo.connect(change_info_ammo("decrease"))
	global_signals.pizza_refilled.connect(change_info_ammo("increase"))

func change_info_ammo(type: String):
	match type:
		"increase":
			ammo+=1;
		"decrease":
			ammo-=1;
	
	$ammo_show.text = $"pizza: {ammo}"
	
