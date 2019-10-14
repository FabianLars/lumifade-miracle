extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# funcs connected in node-menu (Godot Ui)
# TODO: Actually resuming the game
func main_menu_continue_pressed():
    Global.goto_scene("res://Allgemein/EntryLevel.tscn")

func main_menu_new_game_pressed():
    Global.goto_scene("res://Allgemein/EntryLevel.tscn")