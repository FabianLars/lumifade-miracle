extends Area

var areaEntered = false
var doorOpen = false
var doorText = false
var cam = null
var camera_change = Vector2()

func _ready():
	connect("body_entered", self, "on_body_enter")
	connect("body_exited", self, "on_body_exit")
	$doorText.visible = false
	cam = get_tree().get_root().get_camera()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_change = event.relative

func _process(delta):
	if Input.is_action_just_pressed("ui_E"):
		if areaEntered == true:
				
			if doorOpen == false:
				$rotAchseY.rotate_y(rad2deg(90))
				$doorText.set_text("[ E ] Tür schließen")
				doorOpen = true
				
			
			elif doorOpen == true:
				$rotAchseY.rotate_y(rad2deg(-90))
				$doorText.set_text("[ E ] Tür öffnen")
				doorOpen = false

	if camera_change.length() > 0 && areaEntered:
		if !cam.is_position_behind($rotAchseY.get_translation()):
			$doorText.visible = true
		else:
			$doorText.visible = false

func on_body_enter(body):
	if body.name == "Player":
		areaEntered = true
		
		if doorOpen == false:
			$doorText.set_text("[ E ] Tür öffnen")
		elif doorOpen == true:
			$doorText.set_text("[ E ] Tür schließen")

func on_body_exit(body):
	if body.name == "Player":
		areaEntered = false
		$doorText.visible = false
