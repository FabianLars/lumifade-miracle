extends Node

# TODO: Documentation
const MAIN_MENU_PATH = "res://Allgemein/MainMenu.tscn"

const POPUP_SCENE = preload("res://Allgemein/PauseMenu.tscn")
var popup = null

var canvas_layer = null

const DEBUG_DISPLAY_SCENE = preload("res://Allgemein/DebugDisplay.tscn")
var debug_display = null

func _ready():
    canvas_layer = CanvasLayer.new()
    add_child(canvas_layer)

    set_debug_display(true)# TODO: Move into options menu

func goto_scene(path):
    get_tree().change_scene(path)

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        if popup == null:
            popup = POPUP_SCENE.instance()
            popup.get_node("Button_quit").connect("pressed", self, "popup_quit")
            popup.connect("popup_hide", self, "popup_closed")
            popup.get_node("Button_resume").connect("pressed", self, "popup_closed")

            canvas_layer.add_child(popup)
            popup.popup_centered()

            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

            get_tree().paused = true

func popup_closed():
    get_tree().paused = false
    if popup != null:
        popup.queue_free()
        popup = null

func popup_quit():
    get_tree().paused = false
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    if popup != null:
        popup.queue_free()
        popup = null
        goto_scene(MAIN_MENU_PATH)

func set_debug_display(display_on):
    if display_on == false:
        if debug_display != null:
            debug_display.queue_free()
            debug_display = null
    else:
        if debug_display == null:
            debug_display = DEBUG_DISPLAY_SCENE.instance()
            canvas_layer.add_child(debug_display)