extends Node

@onready var audio_player_switch: AudioStreamPlayer = $Switch_Player

func _ready() -> void:
	global_signals.game_start.connect(play_switch_sound)
	global_signals.change_level.connect(play_switch_sound)
	global_signals.game_end.connect(play_switch_sound)

func play_switch_sound():
	audio_player_switch.play()
