extends Area

var areaEntered = false
var doorOpen = false
var chestText = false
var cam = null
var camera_change = Vector2()

func _ready():
	connect("body_entered", self, "on_body_enter")
	connect("body_exited", self, "on_body_exit")
	$chestText.visible = false
	cam = get_tree().get_root().get_camera()
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_change = event.relative
	
func _process(delta):
	if Input.is_action_just_pressed("ui_E"):
		if areaEntered == true:
				
			if doorOpen == false:
				$rotAchse.rotate_x(rad2deg(90))
				$chestText.set_text("[ E ] Truhe schließen")
				doorOpen = true
			
			elif doorOpen == true:
				$rotAchse.rotate_x(rad2deg(-90))
				$doorText.set_text("[ E ] Truhe öffnen")
				doorOpen = false
				
	if camera_change.length() > 0 && areaEntered:
		if !cam.is_position_behind($rotAchse.get_translation()):
			$chestText.visible = true
		else:
			$chestText.visible = false

func on_body_enter(body):
	if body.name == "Player":
		areaEntered = true
		
		if doorOpen == false:
			$chestText.set_text("[ E ] Truhe öffnen")
		elif doorOpen == true:
			$chestText.set_text("[ E ] Truhe schließen")
		
func on_body_exit(body):
	if body.name == "Player":
		areaEntered = false
		$chestText.visible = false
