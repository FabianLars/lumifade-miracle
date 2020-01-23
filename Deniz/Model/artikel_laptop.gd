extends Spatial

var cam = null
var a=null
var b=null
var player=null
func _ready():
	cam=get_parent().get_node("Player/Head/Camera")
	player=get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	a=cam.get_global_transform().basis.z
	b=(get_translation()-cam.get_global_transform().basis.z).normalized()
	var c=a.dot(b)
	print(c)
	if(get_translation().distance_to(get_parent().get_node("Player").get_translation())<0.5):
		if (c<=-0.2 and c>=-0.7):
			if Input.is_action_just_pressed("ui_Z")&& get_parent().get_node("Control_Artikel/LineEdit").is_editable()==false:
				pause_mode = Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Camera_artikel").current=not get_parent().get_node("Camera_artikel").current
				get_parent().get_node("Micro_Camera").current=false
				get_parent().get_node("Camera_Prof_book").current=false
				get_parent().get_node("Camera_Board").current=false
				get_tree().paused=not get_tree().paused
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_parent().get_node("Control_Artikel").pause_mode=Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Control_Artikel").visible=not get_parent().get_node("Control_Artikel").visible
				get_parent().get_node("Control_Artikel/LineEdit").set_editable(not get_parent().get_node("Control_Artikel/LineEdit").is_editable())
				get_parent().get_node("Control_Artikel/LineEdit").connect("text_changed", self, "_on_text_changed")
				
func _on_text_changed(text):
	if(get_parent().get_node("Control_Artikel/LineEdit").get_text()=="B"):
		get_parent().get_node("Control_Artikel/LineEdit").set_editable(false)
		get_parent().get_node("Teilcode2").set_text(get_parent().get_node("Teilcode2").get_text()+", 5")