extends "res://movement_strategy.gd"

const SkaterStates = preload("res://SkaterStates.gd")

var _crouched


# Called when the node enters the scene tree for the first time.
func _ready():
	_crouched = false

func move(skater, delta):
	apply_gravity(skater)
	apply_before_collision_input(skater)
	
	var initialCollision = skater.move_and_collide(skater.regularVelocity * delta)
	# do processing first
	if(initialCollision):
		apply_after_collision_input(initialCollision, skater)
		var remainder_movement = Vector2(initialCollision.remainder.x, 0)
		print(remainder_movement)
		skater.move_and_collide(remainder_movement)


func apply_gravity(skater):
	if(skater.regularVelocity.y >= 250):
		skater.regularVelocity.y = 250
	
	skater.regularVelocity.y += 30
	pass

func apply_before_collision_input(skater):
	var maximum = 450 if _crouched else 300
	if Input.is_action_pressed("ui_right"):
		skater.regularVelocity = increase_x_by_or_clamp(skater.regularVelocity, 5, maximum)
	elif Input.is_action_pressed("ui_left"):
		skater.regularVelocity = decrease_x_by_or_clamp(skater.regularVelocity, 5, -1*maximum)
	else:
		skater.regularVelocity = apply_horizontal_friction(skater.regularVelocity)
			
func apply_after_collision_input(initialCollision, skater):
	if(skater.regularVelocity.x < 0.1 && skater.regularVelocity.x > -0.1):
		_crouched = false
		skater._state_manager.dismount()
		pass
	if Input.is_action_pressed("ollie_button"):
		_crouched = true
	else:
		if(_crouched):
			if(initialCollision && initialCollision.normal.x == 0):
				#jump
				skater.regularVelocity.y -= abs(skater.regularVelocity.x * 3)
		_crouched = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# HELPER METHODS

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
	


func get_applicable_status():
	return SkaterStates.SKATING
