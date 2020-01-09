extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

#walk variables
var gravity = -9.8 * 3
const MAX_SPEED = 10
const MAX_RUNNING_SPEED = 20
const ACCEL = 1.5
const DEACCEL = 6

#jumping
var jump_height = 15
var has_contact = false

#slope variables
const MAX_SLOPE_ANGLE = 35

#stair variables
const MAX_STAIR_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6

onready var ray = $Head/Camera/CollisionRay
var ziellevel = null

func _ready():
    if Global.player_pos != null:
        translation = Global.player_pos
        Global.player_pos = null
    if Global.player_rota_head != null:
        $Head.rotation_degrees = Global.player_rota_head
        Global.player_rota_head = null
    if Global.player_rota_cam != null:
        $Head/Camera.rotation_degrees = Global.player_rota_cam
        Global.player_rota_cam = null

func _physics_process(delta):
    if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

    # Interacting with objects via raycasts
    if ray.is_colliding():
        if ray.get_collider().get_name() == "SB_TV":
            Global.set_overlay(true)
            if Input.is_action_pressed("ui_E"):
                ziellevel = 'Lukas'
        elif ray.get_collider().get_name() == "SB_Sessel":
            Global.set_overlay(true)
            if Input.is_action_pressed("ui_E"):
                ziellevel = 'Deniz'
        elif ray.get_collider().get_name() == "SB_Notebook":
            Global.set_overlay(true)
            if Input.is_action_pressed("ui_E"):
                ziellevel = 'Mike'
        else:
            Global.set_overlay(false)
    else:
        Global.set_overlay(false)

    if(ziellevel != null):

        if ziellevel == 'Lukas':
            translation = translation.linear_interpolate(Vector3(-5.5, 2.8, 7.75), delta*3)
            rotation = rotation.linear_interpolate(Vector3(deg2rad(5.5), deg2rad(-180), 0), delta*3)
            $Head.rotation = $Head.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)
            $Head/Camera.rotation = $Head/Camera.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)

            if translation.x >= -5.52 and translation.x <= -5.48:
                Global.goto_scene("res://Lukas/Main.tscn")

        elif ziellevel == 'Deniz':
            translation = translation.linear_interpolate(Vector3(7.3, 1.3, 7.35), delta*3)
            rotation = rotation.linear_interpolate(Vector3(deg2rad(-55), deg2rad(-132), 0), delta*3)
            $Head.rotation = $Head.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)
            $Head/Camera.rotation = $Head/Camera.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)

            if translation.y >= 1.28 and translation.y <= 1.32:
                Global.goto_scene("res://Deniz/Level.tscn")

        elif ziellevel == 'Mike':
            translation = translation.linear_interpolate(Vector3(4.7, 1, -2.85), delta*3)
            rotation = rotation.linear_interpolate(Vector3(0, deg2rad(-48), 0), delta*3)
            $Head.rotation = $Head.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)
            $Head/Camera.rotation = $Head/Camera.rotation.linear_interpolate(Vector3(0, 0, 0), delta*3)

            if translation.y >= 0.98 and translation.y <= 1.02:
                Global.goto_scene("res://Mike/Main.tscn")

    else:
        aim()
        walk(delta)

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        camera_change = event.relative

func walk(delta):
    # reset the direction of the player
    direction = Vector3()

    # get the rotation of the camera
    var aim = $Head/Camera.get_global_transform().basis
    # check input and change direction
    if Input.is_action_pressed("move_forward"):
        direction -= aim.z
    if Input.is_action_pressed("move_backward"):
        direction += aim.z
    if Input.is_action_pressed("move_left"):
        direction -= aim.x
    if Input.is_action_pressed("move_right"):
        direction += aim.x
    direction.y = 0
    direction = direction.normalized()

    if (is_on_floor()):
        has_contact = true
        var n = $Tail.get_collision_normal()
        var floor_angle = rad2deg(acos(n.dot(Vector3(0, 1, 0))))
        if floor_angle > MAX_SLOPE_ANGLE:
            velocity.y += gravity * delta

    else:
        if !$Tail.is_colliding():
            has_contact = false
        velocity.y += gravity * delta

    if (has_contact and !is_on_floor()):
        move_and_collide(Vector3(0, -1, 0))

    if (direction.length() > 0 and $StairCatcher.is_colliding()):
        var stair_normal = $StairCatcher.get_collision_normal()
        var stair_angle = rad2deg(acos(stair_normal.dot(Vector3(0, 1, 0))))
        if stair_angle < MAX_STAIR_SLOPE:
            velocity.y = STAIR_JUMP_HEIGHT
            has_contact = false


    var temp_velocity = velocity
    temp_velocity.y = 0

    var speed
    if Input.is_action_pressed("move_sprint"):
        speed = MAX_RUNNING_SPEED
    else:
        speed = MAX_SPEED


    # where would the player go at max speed
    var target = direction * speed

    var acceleration
    if direction.dot(temp_velocity) > 0:
        acceleration = ACCEL
    else:
        acceleration = DEACCEL

    # calculate a portion of the distance to go
    temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)

    velocity.x = temp_velocity.x
    velocity.z = temp_velocity.z

    if has_contact and Input.is_action_just_pressed("jump"):
        velocity.y = jump_height
        has_contact = false

    # move
    velocity = move_and_slide(velocity, Vector3(0, 1, 0))

    $StairCatcher.translation.x = direction.x
    $StairCatcher.translation.z = direction.z

func aim():
    if camera_change.length() > 0:
        $Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))

        var change = -camera_change.y * mouse_sensitivity
        if change + camera_angle < 90 and change + camera_angle > -90:
            $Head/Camera.rotate_x(deg2rad(change))
            camera_angle += change
        camera_change = Vector2()

func save():
    return {
        "level": get_tree().get_current_scene().filename,
        "pos_x": translation.x,
        "pos_y": translation.y,
        "pos_z": translation.z,
        "rota_cam": $Head/Camera.rotation_degrees.x,
        "rota_head": $Head.rotation_degrees.y,
    }