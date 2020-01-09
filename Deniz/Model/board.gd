extends Spatial

var cam = null
var button=null
var texture=null

func _ready():
	pass


func on_button_pressed():
	get_parent().get_node("Camera_Board").current=false
	get_tree().paused=false
	

func _process(delta):
	if Input.is_action_just_pressed("ui_Z"):
		
		if(get_translation().distance_to(get_parent().get_node("Player").get_translation())<4):
			pause_mode = Node.PAUSE_MODE_PROCESS
			get_parent().get_node("Camera_Board").current=not get_parent().get_node("Camera_Board").current
			get_parent().get_node("Micro_Camera").current=false
			get_tree().paused=not get_tree().paused
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
		else:
			pause_mode = Node.PAUSE_MODE_INHERIT
				
			