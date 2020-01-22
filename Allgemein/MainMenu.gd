extends CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    Global.set_overlay(false)
    
func load_settings():
    $MenuContainer/OptionsMenu/HSlider.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
    $MenuContainer/OptionsMenu/CheckDebug.pressed = Global.debugdisplay
    $MenuContainer/OptionsMenu/CheckFullscreen.pressed = OS.window_fullscreen
    $MenuContainer/OptionsMenu/CheckMenumusic.pressed = Global.menumusic


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
    elif button == "menumusic":
        $AudioStreamPlayer.playing = !$AudioStreamPlayer.playing
    elif button == "back":
        Global.save_settings()
        $MenuContainer/StartMenu.visible = true
        $MenuContainer/OptionsMenu.visible = false
    else:
        pass

func _on_volume_slider_changed(val):
    Global.set_global_vol(val)
    
func save_settings_to_file():
    return {
        "volume_slider": db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))),
        "debug": Global.debugdisplay,
        "fullscreen": OS.window_fullscreen,
        "menumusic": $AudioStreamPlayer.playing,
    }