extends KinematicBody2D

var grindVelocityMagnitude := 0
# TODO: make private and make access abstracted
var grindingRail = null
var regularVelocity := Vector2(0,0)
var crouched := false
var camera : Camera2D

var movementStrategyManager

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if(child is Camera2D):
			camera = child
		if(child is Node):
			movementStrategyManager = child
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
	movementStrategyManager.get_strategy_for_status(get_status()).move(self, delta)
	

func get_status():
	if(grindingRail):
		return "GRINDING"
	else:
		return "SKATING"
