extends KinematicBody2D

var grindVelocityMagnitude := 0
var grindingRail = null
var regularVelocity := Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if(grindingRail):
		pass
	else:
		regular_movement_strategy(delta)

		
	
	
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
	if Input.is_action_pressed("ui_right"):
		regularVelocity = increase_x_by_or_clamp(regularVelocity, 5, 300)
	elif Input.is_action_pressed("ui_left"):
		regularVelocity = decrease_x_by_or_clamp(regularVelocity, 5, -300)
	else:
		regularVelocity = apply_horizontal_friction(regularVelocity)
			
func apply_after_collision_input(initialCollision):
	if Input.is_action_pressed("ollie_button"):
		if(initialCollision && initialCollision.normal.x == 0):
			regularVelocity.y -= abs(regularVelocity.x * 3)

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
	
