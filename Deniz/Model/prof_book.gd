extends Spatial

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
	if get_translation().distance_to(get_parent().get_node("Player").get_translation())<4:
		if acos(a.dot(b)) <= deg2rad(60):
			get_parent().get_node("press").visible=true
			if Input.is_action_just_pressed("ui_Z"):
				get_parent().get_node("press").visible=false
				pause_mode = Node.PAUSE_MODE_PROCESS
				get_parent().get_node("Camera_Prof_book").current=not get_parent().get_node("Camera_Prof_book").current
				if get_parent().get_node("Camera_Prof_book").current==false:
					get_parent().get_node("Player/Head/Camera").current=true
					get_node("AnimationPlayer").play_backwards("Plane.001Action.001")

				if get_parent().get_node("Camera_Prof_book").current==true:
					get_node("AnimationPlayer").play("Plane.001Action.001")
				get_parent().get_node("Micro_Camera").current=false
				get_parent().get_node("Camera_Board").current=false
				get_parent().get_node("Camera_artikel").current=false
				get_parent().get_node("Camera_Open_book").current=false
				get_parent().get_node("Camera_Riddle4").current=false
				get_tree().paused=not get_tree().paused
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)




		else:
			get_parent().get_node("press").visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
