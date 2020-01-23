extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused=true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("Button").connect("pressed",self,"_button_pressed")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	pass
	
	
func _button_pressed():
	if (get_node("ColorRect2").visible==false):
		get_node("ColorRect2").visible=true;
		get_node("Label3").visible=true
	else:
		get_tree().paused=false;
		visible=false
		get_parent().get_node("Teilcode1").visible=true;
		get_parent().get_node("Teilcode2").visible=true;
	
	