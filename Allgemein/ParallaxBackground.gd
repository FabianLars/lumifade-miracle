extends ParallaxBackground

var scroll_x = 0
var revert_scroll = false

func _ready():
    pass

func _process(delta):
    var pos = $ParallaxLayer.global_position.x
    if pos <= -1919.8:
        revert_scroll = true
    if pos >= -0.2:
        revert_scroll = false
    if revert_scroll == false:
        scroll_x -= delta * 50
    if revert_scroll == true:
        scroll_x += delta * 50
    scroll_offset.x = scroll_x