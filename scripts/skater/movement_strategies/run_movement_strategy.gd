extends "res://scripts/skater/movement_strategy.gd"

const SkaterStates = preload("res://scripts/skater/SkaterStates.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(skater, delta):
	if Input.is_action_pressed("ui_right"):
		skater.regularVelocity = Vector2(250,0)
	elif Input.is_action_pressed("ui_left"):
		skater.regularVelocity = Vector2(-250,0)
	else:
		skater.regularVelocity = Vector2(0,0)
		return
	if Input.is_action_pressed("ollie_button"):
		skater._state_manager.mount()
	skater.move_and_collide(skater.regularVelocity*delta)

func get_applicable_status():
	return SkaterStates.RUNNING
