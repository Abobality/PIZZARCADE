extends Node2D

var time_result:int = 0;

func _ready() -> void:
	$CanvasLayer/win_text_show.text = "Congrats! \n Your time: %s" %format_time(time_result)

func format_time(ms:int):
	var total_seconds = ms/1000;
	var minutes = ms / 60000
	var seconds = (ms % 60000) / 1000
	var miliseconds = ms % 1000
	return "%02d:%02d.%03d" % [minutes, seconds, miliseconds]
