extends Area

func _ready():
	connect("body_entered", self, "on_body_enter")

func on_body_enter(body):
	if body.name == "Player":
		$Spider.translate(Vector3(0,-11,0))