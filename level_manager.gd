extends Node2D

var current_level: Node = null;
var current_level_num: int = 0;


func _ready() -> void:
	change_level(1)
	

func change_level(level_num: int):
	var path = "res://level_%d.tscn" % level_num;
	
	if not ResourceLoader.exists(path):
		return; 
		
	if current_level != null:
		current_level.queue_free();
		
	current_level = load(path).instantiate();
	add_child(current_level);
	
	current_level_num = level_num
