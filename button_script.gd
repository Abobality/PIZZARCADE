extends Button

var basic_text: String = "Pineapple"
var hover_text: String = "Nope :3"

func _ready() -> void:
	text = basic_text;
	mouse_entered.connect(mouse_enter);
	mouse_exited.connect(mouse_exit);


func mouse_enter():
	text = hover_text
	disabled = true;

func mouse_exit():
	text = basic_text
	disabled = false;
