extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cam = null
var a=null
var b=null
var player=null
# Called when the node enters the scene tree for the first time.
func _ready():
	cam=get_parent().get_node("Player/Head/Camera")
	player=get_parent().get_node("Player")
	
	
func _process(delta):
	a=cam.get_global_transform().basis.z
	b=(get_translation()-cam.get_global_transform().basis.z).normalized()
	var c=a.dot(b)
	#print(c)
	if get_translation().distance_to(get_parent().get_node("Player").get_translation())<4:
		print("1")
		if(c>0.5 and c<=1.0):
			print("2")
			if Input.is_action_just_pressed("ui_Z"):
				print("hihi")
				pause_mode = Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Camera_Prof_book").current=not get_parent().get_node("Camera_Prof_book").current
				get_parent().get_node("Micro_Camera").current=false
				get_parent().get_node("Camera_Board").current=false
				get_parent().get_node("Camera_artikel").current=false
				get_parent().get_node("Camera_Open_book").current=false
				get_tree().paused=not get_tree().paused
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				
				
				
				
	#else:
	#	pause_mode = Node.PAUSE_MODE_INHERIT
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
