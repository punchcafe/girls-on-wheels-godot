extends KinematicBody2D

var grindVelocityMagnitude := 0
var grindingRail = null
var regularVelocity := Vector2(0,0)
var crouched := false
var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if(child is Camera2D):
			camera = child
	pass # Replace with function body.

func _process(delta):
	var lower_lim = 0.6
	var upper_lim = 1.0
	var ratio = abs(regularVelocity.x/350)
	var x_zoom : float
	if(ratio < lower_lim):
		x_zoom = lower_lim
	elif(ratio > upper_lim):
		x_zoom = upper_lim
	else:
		x_zoom = ratio
	camera.zoom = Vector2(x_zoom,x_zoom)

func _physics_process(delta):
	if(grindingRail):
		grinding_movement(delta)
	else:
		regular_movement_strategy(delta)

		
func grinding_movement(delta):
	var velocity = grindingRail.railAngle * regularVelocity.length() * (abs(regularVelocity.x)/regularVelocity.x)
	if !Input.is_action_pressed("ollie_button"):
		print("released!")
		print(crouched)
		grindingRail = null
		regularVelocity.y -= 1000
		regularVelocity.x = velocity.x
		crouched = false
	move_and_collide(velocity*delta)
	
	#velocity = velocity.normalized() * 250
	
#### REGULAR MOVEMENT STRATEGY

func regular_movement_strategy(delta):
	apply_gravity()
	apply_before_collision_input()
	
	var initialCollision = move_and_collide(regularVelocity * delta)
	# do processing first
	if(initialCollision):
		apply_after_collision_input(initialCollision)
		var remainder_movement = Vector2(initialCollision.remainder.x, 0)
		print(remainder_movement)
		move_and_collide(remainder_movement)

func apply_gravity():
	if(regularVelocity.y >= 250):
		regularVelocity.y = 250
	
	regularVelocity.y += 30
	pass

func apply_before_collision_input():
	var maximum = 450 if crouched else 300
	if Input.is_action_pressed("ui_right"):
		regularVelocity = increase_x_by_or_clamp(regularVelocity, 5, maximum)
	elif Input.is_action_pressed("ui_left"):
		regularVelocity = decrease_x_by_or_clamp(regularVelocity, 5, -1*maximum)
	else:
		regularVelocity = apply_horizontal_friction(regularVelocity)
			
func apply_after_collision_input(initialCollision):
	if Input.is_action_pressed("ollie_button"):
		crouched = true
	else:
		if(crouched):
			if(initialCollision && initialCollision.normal.x == 0):
				#jump
				regularVelocity.y -= abs(regularVelocity.x * 3)
		crouched = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func increase_x_by_or_clamp(vector, increase, limit):
	if(vector.x >= limit):
		vector.x = limit
		return vector
	vector.x += increase
	return vector
	
func decrease_x_by_or_clamp(vector, decrease, limit):
	if(vector.x <= limit):
		vector.x = limit
		return vector
	vector.x -= decrease
	return vector

func apply_horizontal_friction(regularVelocity):
	#TODO: factor in angle
	regularVelocity.x = regularVelocity.x + 0.05*-1*regularVelocity.x
	return regularVelocity
	
