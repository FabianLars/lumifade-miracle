extends Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	print(self.name)
	if body.name == "Player" || body.name == "Gary" || body.name == "Character":
		if self.name == "AreaDF":
			Global.goto_scene("res://FabianLars/Main.tscn")

		elif self.name == "AreaDD":
			Global.goto_scene("res://Deniz/Level.tscn")

		elif self.name == "AreaDM":
			Global.goto_scene("res://Mike/Main.tscn")

		elif self.name == "AreaDL":
			Global.goto_scene("res://Lukas/Main.tscn")