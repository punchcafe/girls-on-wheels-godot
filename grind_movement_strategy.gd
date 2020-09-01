extends "res://movement_strategy.gd"

const SkaterStates = preload("res://SkaterStates.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(skater, delta):
	var velocity = skater._state_manager.get_grinding_rail().railAngle * skater.regularVelocity.length() * (abs(skater.regularVelocity.x)/skater.regularVelocity.x)
	if !Input.is_action_pressed("ollie_button"):
		skater._state_manager.jump_off_rail()
		skater.regularVelocity.y -= 1000
		skater.regularVelocity.x = velocity.x
	skater.move_and_collide(velocity*delta)

func get_applicable_status():
	return SkaterStates.GRINDING
