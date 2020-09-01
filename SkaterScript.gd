extends KinematicBody2D

const SkaterStates = preload("res://SkaterStates.gd")

var grindVelocityMagnitude := 0
var run = false
# TODO: make private and make access abstracted
var grindingRail = null
var regularVelocity := Vector2(0,0)
var camera : Camera2D

# Manager instances

var movementStrategyManager
var _state_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if(child is Camera2D):
			camera = child
		if(child.get_name() == "MovementStrategyManager"):
			movementStrategyManager = child
		if(child.get_name() == "StateManager"):
			_state_manager = child
	pass # Replace with function body.

func _process(delta):
	_mvp_animation_calculator()
	var lower_lim = 0.6
	var upper_lim = 1.0
	var ratio = abs(regularVelocity.x/350)-0.1
	var x_zoom : float
	if(ratio < lower_lim):
		x_zoom = lower_lim
	elif(ratio > upper_lim):
		x_zoom = upper_lim
	else:
		x_zoom = ratio
	camera.zoom = Vector2(x_zoom,x_zoom)

func _physics_process(delta):
	movementStrategyManager.get_strategy_for_status(get_status()).move(self, delta)
	
func _mvp_animation_calculator():
	if(get_status() == SkaterStates.SKATING):
		if(movementStrategyManager.is_crouched()):
			if(regularVelocity.x > 0):
				$AnimationPlayer.play("SKATE_CROUCHING_RIGHT")
			else:
				$AnimationPlayer.play("SKATE_CROUCHING_LEFT")
		else:
			if(regularVelocity.x > 0):
				$AnimationPlayer.play("SKATE_STANDING_RIGHT")
			else:
				$AnimationPlayer.play("SKATE_STANDING_LEFT")
	elif(get_status() == SkaterStates.GRINDING):
		if(regularVelocity.x > 0):
			$AnimationPlayer.play("GRINDING_RIGHT")
		else:
			$AnimationPlayer.play("GRINDING_LEFT")
	elif(get_status() == SkaterStates.RUNNING):
		if(regularVelocity.x < 1 && regularVelocity.x > -1):
			$AnimationPlayer.play("STANDING")
		elif(regularVelocity.x > 0):
			$AnimationPlayer.play("RUNNING_RIGHT")
		else:
			$AnimationPlayer.play("RUNNING_LEFT")

func get_status():
	return _state_manager.get_current_state()
