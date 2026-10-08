extends Area2D
class_name child

@export var hungry: int = 3;

func feed():
	hungry-=1;
	
	if hungry <= 0:
		queue_free();
