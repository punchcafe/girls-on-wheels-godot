extends "res://movement_strategy.gd"

const SkaterStates = preload("res://SkaterStates.gd")
const time_on_wall_limit = 0.25

var time_on_wall := 0.0

var slide_velocity = Vector2(0, 100)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(skater, delta):
	if(time_on_wall > time_on_wall_limit):
		_launch_skater_off_wall(skater, false)
		pass
	if(Input.is_action_pressed("ollie_button")):
		if(time_on_wall == 0):
			# User did not release ollie before landing
			_launch_skater_off_wall(skater, false)
			pass
		else:
			print("success")
			_launch_skater_off_wall(skater, true)
			pass
	skater.move_and_collide(slide_velocity*delta)
	time_on_wall += delta
	print("owch!")
	print(time_on_wall)

func get_applicable_status():
	return SkaterStates.WALL_HANGING
	
func _launch_skater_off_wall(skater, success):
	time_on_wall = 0
	var release_vector = get_release_vector(success, skater._state_manager._hanging_wall_collision)
	skater.regularVelocity = release_vector    
	skater._state_manager.release_wall()
	
func get_release_vector(success, collision):
	var x = -300 if collision.remainder.x > 0 else 300
	var y = -900 if success else 300
	return Vector2(x,y)


