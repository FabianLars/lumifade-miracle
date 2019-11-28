extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

#walk variables
var gravity = -9.8 * 3
const MAX_SPEED = 20
const MAX_RUNNING_SPEED = 30
const ACCEL = 2
const DEACCEL = 6

#jumping
var jump_height = 15
var has_contact = false

#Tools
var current_tool_name = "TRANSLOCATOR"
var teleportAvailable = false

#Disk vom Translocator
var disc_scene = preload("res://Mike/Disc.tscn")
const DISC_SHOOT_FORCE = 250

#slope variables
const MAX_SLOPE_ANGLE = 35

#stair variables
const MAX_STAIR_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6

func _ready():
	pass

func _physics_process(delta):
    if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    aim()
    inputandmovement(delta)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_change = event.relative

func inputandmovement(delta):
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

	#Tools:
	#Aktuelles Tool
	if Input.is_action_pressed("Key1"):
		current_tool_name = "TRANSLOCATOR"
		print(current_tool_name)
	if Input.is_action_pressed("Key2"):
		current_tool_name = "UNARMED"
		print(current_tool_name)

	#Fire
	if Input.is_action_just_pressed("primary.fire") and current_tool_name == "TRANSLOCATOR":
		shootDisc()
		print("Disc geschossen")
		teleportAvailable = true

	if Input.is_action_just_pressed("alt.fire") and teleportAvailable and current_tool_name == "TRANSLOCATOR":
		#Teleportieren
		var discPos = disc_clone.translation
		set_translation(discPos)

		#Disc löschen
		disc_clone.queue_free()
		disc_clone = null
		teleportAvailable = false
		print("Spieler wird teleportiert")
		print("Disc gelÃ¶scht")


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


var disc_clone = null
func shootDisc():
	if disc_clone != null:
		disc_clone.queue_free()
		disc_clone = null

	disc_clone = disc_scene.instance()
	get_parent().add_child(disc_clone)
	disc_clone.global_transform = $Head/Camera.global_transform
	disc_clone.apply_impulse(Vector3(0,0,0), disc_clone.global_transform.basis.z * -DISC_SHOOT_FORCE)
# TODO: Refactor Levels to use this Character instead of their own Gary
