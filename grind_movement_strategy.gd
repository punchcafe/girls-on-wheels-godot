extends "res://movement_strategy.gd"

const SkaterStates = preload("res://SkaterStates.gd")
const rail_mount_utility = preload("res://rail_mount_utility.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(skater, delta):
	if(skater.regularVelocity.angle_to(skater._state_manager.get_grinding_rail().get_rail_angle()) != 0
	|| skater.regularVelocity.angle_to(skater._state_manager.get_grinding_rail().get_rail_angle()) != 180):
		skater.regularVelocity = rail_mount_utility.get_velocity_component_in_rail_direction(skater.regularVelocity, skater._state_manager.get_grinding_rail().get_rail_angle())
		
	var velocity = skater._state_manager.get_grinding_rail().get_rail_angle() * skater.regularVelocity.length() * (abs(skater.regularVelocity.x)/skater.regularVelocity.x)
	if !Input.is_action_pressed("ollie_button"):
		skater._state_manager.jump_off_rail()
		skater.regularVelocity.y -= 1000
		skater.regularVelocity.x = velocity.x
	skater.move_and_collide(velocity*delta)

func get_applicable_status():
	return SkaterStates.GRINDING
