extends Area

var areaEntered = false
var doorOpen = false

func _ready():
	connect("body_entered", self, "on_body_enter")
	connect("body_exited", self, "on_body_exit")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_E"):
		if areaEntered == true:
				
			if doorOpen == false:
				$rotAchse.rotate_x(rad2deg(90))
				doorOpen = true
			
			elif doorOpen == true:
				$rotAchse.rotate_x(rad2deg(-90))
				doorOpen = false

func on_body_enter(body):
	if body.name == "Player":
		areaEntered = true
		
func on_body_exit(body):
	if body.name == "Player":
		areaEntered = false
