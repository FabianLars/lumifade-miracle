extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    Global.set_overlay(false)

# funcs connected in node-menu (Godot Ui)
# TODO: Actually resuming the game
func main_menu_continue_pressed():
    Global.load_game()

func main_menu_new_game_pressed():
    Global.goto_scene("res://MainHub/Level.tscn")

func main_menu_options_pressed():
    $MenuContainer/OptionsMenu.visible = true
    $MenuContainer/StartMenu.visible = false

func main_menu_quit_game_pressed():
    get_tree().quit()

func options_menu_button_pressed(button):
    if button == "vsync":
        pass
    elif button == "debug":
        Global.set_debug_display($MenuContainer/OptionsMenu/CheckDebug.pressed)
    elif button == "fullscreen":
        OS.window_fullscreen = !OS.window_fullscreen
    elif button == "back":
        $MenuContainer/StartMenu.visible = true
        $MenuContainer/OptionsMenu.visible = false
    else:
        pass