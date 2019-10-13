extends KinematicBody

var camera_angle=0
var mouse_sensitivity=0.3

var velocity=Vector3()
var direction= Vector3()


#walk
var gravity=0
const MAX_SPEED=10
const ACCEL=2
const DEACCEL=6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	walk(delta)

func walk(delta):
	#reset the direction of the player
	direction=Vector3()
	
	#get the rotation of the camera
	var aim=$Head/Camera.get_global_transform().basis
	#check input and change direction
	if Input.is_action_pressed("move_forward"):
		direction-=aim.z
	if Input.is_action_pressed("move_backward"):
		direction+=aim.z
	if Input.is_action_pressed("move_left"):
		direction-=aim.x
	if Input.is_action_pressed("move_right"):
		direction+=aim.x
	
	direction=direction.normalized()
	velocity.y+=gravity*delta
	var temp_velocity=velocity
	temp_velocity.y=0
	var speed
	speed=MAX_SPEED
	
	var target = direction*speed
	
	var acceleration
	if direction.dot(temp_velocity)>0:
		acceleration=ACCEL
	else: 
		acceleration=DEACCEL
	
	
	temp_velocity =temp_velocity.linear_interpolate(target,acceleration*delta)
	velocity.x=temp_velocity.x
	velocity.z=temp_velocity.z
	#move
	velocity=move_and_slide(velocity,Vector3(0,1,0))




func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x*mouse_sensitivity))
		
		var change= -event.relative.y*mouse_sensitivity
		if change+ camera_angle <90 and change + camera_angle >-90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle+=change
			
		
		

