extends Spatial


var cam = null

func _ready():
	
	cam =get_parent().get_node("Player/Head/Camera")
	

func _process(delta):
	if Input.is_action_just_pressed("ui_Z"):
		if(get_translation().distance_to(get_parent().get_node("Player").get_translation())<4):
			print(get_parent().get_node("Player").get_translation)
			#get_parent().get_node("Player").set_translation(Vector3(7.803527, 1.665368, -6.924295))
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
