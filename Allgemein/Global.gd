extends Node

# TODO: Documentation
const MAIN_MENU_PATH = "res://Allgemein/MainMenu.tscn"

const POPUP_SCENE = preload("res://Allgemein/PauseMenu.tscn")
var popup = null

const OVERLAY_SCENE = preload("res://Allgemein/Overlay.tscn")
var overlay = null

var canvas_layer = null

const DEBUG_DISPLAY_SCENE = preload("res://Allgemein/DebugDisplay.tscn")
var debug_display = null

var menumusic = true
var debugdisplay = false

var player_pos = null
var player_rota_head = null
var player_rota_cam

func _ready():
    canvas_layer = CanvasLayer.new()
    add_child(canvas_layer)
    load_settings()

func goto_scene(path):
    get_tree().change_scene(path)
    set_overlay(false)
    load_settings()

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel") and get_tree().get_current_scene().name != "MainMenuContainer":
        if popup == null:
            popup = POPUP_SCENE.instance()
            popup.get_node("Button_quit").connect("pressed", self, "popup_quit")
            popup.connect("popup_hide", self, "popup_closed")
            popup.get_node("Button_resume").connect("pressed", self, "popup_closed")
            popup.get_node("Button_hub").connect("pressed", self, "popup_hub")

            canvas_layer.add_child(popup)
            popup.popup_centered()

            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

            get_tree().paused = true

func set_global_vol(val):
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(val))

func popup_closed():
    get_tree().paused = false
    if popup != null:
        popup.queue_free()
        popup = null

func popup_hub():
    get_tree().paused = false
    goto_scene("res://MainHub/Level.tscn")
    if popup != null:
        popup.queue_free()
        popup = null

func popup_quit():
    save_game();
    get_tree().paused = false
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    if popup != null:
        popup.queue_free()
        popup = null
        goto_scene(MAIN_MENU_PATH)

func set_debug_display(display_on):
    debugdisplay = display_on
    if display_on == false:
        if debug_display != null:
            debug_display.queue_free()
            debug_display = null
    else:
        if debug_display == null:
            debug_display = DEBUG_DISPLAY_SCENE.instance()
            canvas_layer.add_child(debug_display)

func save_game():
    var save_game = File.new()
    save_game.open("user://savegame.save", File.WRITE)
    var save_nodes = get_tree().get_nodes_in_group("Persist")
    for i in save_nodes:
        var node_data = i.call("save");
        save_game.store_line(to_json(node_data))
    save_game.close()

func load_game():
    var save_game = File.new()
    if not save_game.file_exists("user://savegame.save"):
        return

    save_game.open("user://savegame.save", File.READ)
    while not save_game.eof_reached():
        var current_line = parse_json(save_game.get_line())
        if current_line != null:
            player_pos = Vector3(current_line["pos_x"], current_line["pos_y"], current_line["pos_z"])
            player_rota_head = Vector3(0, current_line["rota_head"], 0)
            player_rota_cam = Vector3(current_line["rota_cam"], 0, 0)
            goto_scene(current_line["level"])
    save_game.close()
    
func save_settings():
    var settings_file = File.new()
    settings_file.open("user://settings.json", File.WRITE)
    var settings_nodes = get_tree().get_nodes_in_group("Settings")
    for i in settings_nodes:
        var node_data = i.call("save_settings_to_file");
        settings_file.store_line(to_json(node_data))
    settings_file.close()
    
func load_settings():
    var settings_file = File.new()
    if not settings_file.file_exists("user://settings.json"):
        return
    settings_file.open("user://settings.json", File.READ)
    while not settings_file.eof_reached():
        var current_line = parse_json(settings_file.get_line())
        if current_line != null:
            if current_line.has("volume_slider"):
                set_global_vol(current_line["volume_slider"])
            if current_line.has("menumusic"):
                menumusic = current_line["menumusic"]
            if current_line.has("fullscreen"):
                OS.window_fullscreen = current_line["fullscreen"]
            if current_line.has("debug"):
                set_debug_display(current_line["debug"])
            if current_line.has("vsync"):
                OS.vsync_enabled = (current_line["vsync"])
    settings_file.close()
    var settings_nodes = get_tree().get_nodes_in_group("Settings")
    for i in settings_nodes:
        var node_data = i.call("load_settings");
                
                
            

func set_overlay(overlay_on):
    if overlay_on == false:
        if overlay != null:
            overlay.queue_free()
            overlay = null
    else:
        if overlay == null:
            overlay = OVERLAY_SCENE.instance()
            canvas_layer.add_child(overlay)