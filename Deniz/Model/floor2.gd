extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a=0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	if(a<1):
		if Input.is_action_just_pressed("ui_Z"):
			get_node("AnimationPlayer").play("Plane.004Action")
			a=a+1

