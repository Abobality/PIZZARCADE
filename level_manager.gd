extends Node2D

var levels = {
	"level_1": "res://level_1.tscn",
	"level_2": "res://level_2.tscn",
	"level_3": "res://level_3.tscn",
	"level_4": "res://level_4.tscn",
	"level_5": "res://level_5.tscn",
	"level_6": "res://level_6.tscn",
	"level_7": "res://level_7.tscn",
	"level_8": "res://level_8.tscn",
	"level_9": "res://level_9.tscn"
}

func _ready() -> void:
	add_child(load(levels.level_1).instantiate());
