extends Node2D

@export var PIZZA: PackedScene;
var BULLET_POOL:Array [Node];
var pool_size = 10;

func _ready() -> void:
	for i in range(pool_size):
		var bullet = PIZZA.instantiate()
		bullet.bullet_deactivate() 
		add_child(bullet)          
		BULLET_POOL.append(bullet)
	
func shoot(spawn_position: Vector2, shoot_direction: Vector2):
	if !BULLET_POOL.is_empty():
		BULLET_POOL[0].bullet_activate(spawn_position, shoot_direction)
		BULLET_POOL.pop_front()
		return 
			
	print("Все пули заняты!")
	
func return_bullet(bullet: Node):
	bullet.bullet_deactivate()
	if not BULLET_POOL.has(bullet):
		BULLET_POOL.append(bullet)
