extends Node2D

var score: int = 0
var child_count: int = 0
var current_score: int = 0
var current_task_score: int = 0

func _ready() -> void:
	global_signals.score_gain.connect(score_plus)
	# Подключаемся к сигналу смены уровня, чтобы автоматически 
	# пересчитывать детей, КОГДА новый уровень загрузится
	global_signals.change_level.connect(_on_level_changed)
	
	initialize_level.call_deferred()

func initialize_level():
	# Даем кадру завершиться, чтобы новый уровень успел полностью войти в дерево
	await get_tree().process_frame 
	
	var count = get_tree().get_nodes_in_group("children").size()
	child_count = count
	current_task_score = child_count * 100
	
	print("--- СТАРТ УРОВНЯ ---")
	print("Всего детей на уровне: ", child_count)
	print("Нужно набрать очков: ", current_task_score)

func score_plus(_score: int):
	score += _score
	current_score += _score
	
	# Просто уменьшаем счетчик на 1. Больше НИКАКИХ вызовов get_nodes_in_group() здесь!
	child_count -= 1 
	
	print("Очки: ", current_score, "/", current_task_score, " | Осталось детей: ", child_count)
	
	count_update()

func count_update():
	# Теперь проверка сработает идеально честно
	if current_score >= current_task_score and child_count <= 0:
		print("Уровень пройден успешно!")
		current_score = 0
		global_signals.change_level.emit.call_deferred()

func _on_level_changed():
	# Метод сработает автоматически, когда level_manager переключит сцену
	initialize_level.call_deferred()
