extends Control


var pizza: Array[global_names.COMPONENTS] = [];



func _ready() -> void:
	for btn in find_children("*", "ActionButton", true, false):
		btn.ingridient_push.connect(ingridient_write)

func ingridient_write(ingridient: global_names.COMPONENTS):
	var layer_name = global_names.COMPONENTS.keys()[ingridient].to_lower()
	var layer_node = $pizza.get_node_or_null(layer_name)
	if pizza.has(ingridient):
		pizza.erase(ingridient)
		if layer_node:
			layer_node.visible = false
		return
	pizza.append(ingridient);
	
	if layer_node:
		layer_node.visible = true


func _on_button_pressed() -> void:
	global_names.global_pizza = pizza
	global_signals.game_start.emit()
	print(pizza)
