extends "res://movement_strategy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(skater, delta):
	var velocity = skater.grindingRail.railAngle * skater.regularVelocity.length() * (abs(skater.regularVelocity.x)/skater.regularVelocity.x)
	if !Input.is_action_pressed("ollie_button"):
		print("released!")
		print(skater.crouched)
		skater.grindingRail = null
		skater.regularVelocity.y -= 1000
		skater.regularVelocity.x = velocity.x
		skater.crouched = false
	skater.move_and_collide(velocity*delta)

func get_applicable_status():
	return "GRINDING"
