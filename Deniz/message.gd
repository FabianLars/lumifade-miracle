extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button2").connect("pressed",self,"_on_button_pressed")
	get_node("Button").connect("pressed",self,"_button_pressed2")
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_T"):
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused=true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible=true
		get_node("TextureRect").visible=false
		get_node("Label").visible=false
		get_node("TextureRect2").visible=false
		get_node("Label2").visible=false
		get_node("TextureRect3").visible=false
		get_node("Label3").visible=false
		get_node("TextureRect4").visible=false
		get_node("Label4").visible=false
		get_node("TextureRect5").visible=false
		get_node("Label5").visible=false




func _on_button_pressed():

	if(get_node("TextureRect2").visible==false):
		get_node("TextureRect2").visible=true
		get_node("Label2").visible=true
		get_node("Label2").set_text(get_node("LineEdit").get_text())
		get_node("LineEdit").clear()
		if(get_node("Label2").get_text()=="Tokio"):
			get_node("TextureRect5").visible=true
			get_node("Label5").visible=true
			get_tree().paused=false;
			visible=false
			get_parent().get_node("ende_color").visible=true
		else:
			get_node("TextureRect").visible=true
			get_node("Label").visible=true

	elif (get_node("TextureRect2").visible==true &&get_node("TextureRect4").visible==false):
		get_node("TextureRect4").visible=true
		get_node("Label4").visible=true
		get_node("Label4").set_text(get_node("LineEdit").get_text())
		get_node("LineEdit").clear()
		if(get_node("Label4").get_text()=="Tokio"):
			get_node("TextureRect5").visible=true
			get_node("Label5").visible=true
			get_tree().paused=false;
			visible=false
			get_parent().get_node("ende_color").visible=true
		else:
			get_node("TextureRect3").visible=true
			get_node("Label3").visible=true

	elif (get_node("TextureRect2").visible==true &&get_node("TextureRect4").visible==true):
		get_node("TextureRect").visible=false
		get_node("Label").visible=false
		get_node("TextureRect2").visible=false
		get_node("Label2").visible=false
		get_node("TextureRect3").visible=false
		get_node("Label3").visible=false
		get_node("TextureRect4").visible=false
		get_node("Label4").visible=false
		get_node("TextureRect5").visible=false
		get_node("Label5").visible=false



func _button_pressed2():
	get_tree().paused=false;
	visible=false
