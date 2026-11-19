class_name ActionButton
extends Button

@export var ingridient_index: int;

signal ingridient_push;

func _ready() -> void:
	pressed.connect(func(): ingridient_push.emit(ingridient_index))
