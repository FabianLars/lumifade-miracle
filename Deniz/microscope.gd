extends MeshInstance

var button=null
var texture=null

func _ready():
	texture=get_parent().get_node("MicroRect")
	#button=get_parent().get_node("MicroRect/MicroButton")
	
	
func on_button_pressed():

	get_parent().get_node("Micro_Camera").current=false
	get_parent().get_node("Player/Head/Camera").current=true
	get_tree().paused=false
	#texture.visible=false
	
	
func _process(delta):
	
	if(get_translation().distance_to(get_parent().get_node("Player").get_translation())<2):
		
		if Input.is_action_just_pressed("ui_Z"):
			pause_mode = Node.PAUSE_MODE_PROCESS
			#button.connect("pressed",self,"on_button_pressed")
#			texture.visible=not texture.visible

			get_parent().get_node("Micro_Camera").current=not get_parent().get_node("Micro_Camera").current
			get_parent().get_node("Camera_Board").current=false 
			get_parent().get_node("Camera_Prof_book").current=false 
			get_parent().get_node("Camera_artikel").current=false 
			get_parent().get_node("Camera_Open_book").current=false 
			#get_parent().get_node("Player/Head/Camera").current=not get_parent().get_node("Player/Head/Camera").current
			get_tree().paused=not get_tree().paused
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				
			
	#else:
	#	pause_mode = Node.PAUSE_MODE_INHERIT
