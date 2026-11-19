extends Control

enum COMPONENTS{
	PEPPERONI,
	SAUSAGES,
	BASIL,
	PINEAPPLE,
	MUSHROOM,
	OLIVES
}

var pizza: Array[COMPONENTS] = [];



func _ready() -> void:
	for btn in find_children("*", "ActionButton", true, false):
		btn.ingridient_push.connect(ingridient_write)

func ingridient_write(ingridient: COMPONENTS):
	var layer_name = COMPONENTS.keys()[ingridient].to_lower()
	var layer_node = $pizza.get_node_or_null(layer_name)
	if pizza.has(ingridient):
		pizza.erase(ingridient)
		if layer_node:
			layer_node.visible = false
		return
	pizza.append(ingridient);
	
	if layer_node:
		layer_node.visible = true
