extends Spatial

var cam = null
var a=null
var b=null
var player=null
func _ready():
	cam=get_parent().get_node("Player/Head/Camera")
	player=get_parent().get_node("Player")
	
	
	
	#b=(cam.get_global_transform().basis-get_translation()).normalized()

	

func _process(delta):
	
	a=cam.get_global_transform().basis.z
	b=(get_translation()-cam.get_global_transform().basis.z).normalized()
	var c=a.dot(b)
	if(get_translation().distance_to(get_parent().get_node("Player").get_translation())<2):
		if acos(a.dot(b)) <= deg2rad(90):
			get_parent().get_node("press").visible=true
			if Input.is_action_just_pressed("ui_Z")&& get_parent().get_node("Control_Open_book/LineEdit").is_editable()==false:
				get_parent().get_node("press").visible=false
				pause_mode = Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Camera_Open_book").current=not get_parent().get_node("Camera_Open_book").current
				if get_parent().get_node("Camera_Open_book").current==false:
					get_parent().get_node("Player/Head/Camera").current=true
				get_parent().get_node("Micro_Camera").current=false
				get_parent().get_node("Camera_Prof_book").current=false
				get_parent().get_node("Camera_artikel").current=false
				get_parent().get_node("Camera_Board").current=false
				get_parent().get_node("Camera_Riddle4").current=false
				get_tree().paused=not get_tree().paused
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_parent().get_node("Control_Open_book").pause_mode=Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Control_Open_book").visible=not get_parent().get_node("Control_Open_book").visible
				get_parent().get_node("Control_Open_book/LineEdit").set_editable(not get_parent().get_node("Control_Open_book/LineEdit").is_editable())
				get_parent().get_node("Control_Open_book/LineEdit").connect("text_changed", self, "_on_text_changed")
				
				
		else:
			get_parent().get_node("press").visible=false
	


func _on_text_changed(text):
	if(get_parent().get_node("Control_Open_book/LineEdit").get_text()=="90"):
		get_parent().get_node("Control_Open_book/LineEdit").set_editable(false)
		get_parent().get_node("Teilcode2").set_text(get_parent().get_node("Teilcode2").get_text()+" 53 ")
