extends "res://scripts/level/task.gd"

var rail;
var skater;
# one of READY, IN_PROGRESS, FAILED, COMPLETED
var state;
var direction; #LEFT or RIGHT, meaning sirection or reverse direction of rail
#var chained_rail # if rail is next in a rail task.
var next_rail

# TODO: find out how to inject values through properties

func _ready():
	pass # Replace with function body.
	
# the main loop of the task
func apply_delta(delta):
	pass
	
func prepare():
	pass
	
func start():
	pass

# Returns a boolean whether or not the 
func has_finished():
	if(state == "COMPLETED" || state == "FAILED"):
		return true
	return false

func was_successful():
	pass
	
func handle_inprogress():
	if(next_rail != null && skater.get_current_rail() == next_rail):
		state = "COMPLETED"
	if(next_rail == null && is_skater_in_complete_area()):
		state = "COMPLETED"
	# IF SKATER OFF RAIL, FAIL -> check grinding rail
	# IF SKATER TOO SLOW, FAIL
	# IF SKATER DIRECTION WRONG, FAIL
	# IF SKATER IN SUCESS ZONE, PASS
	
	# IF skater is grinding next rail, pass
	# IF no next rail, and skater is in LEFT / RIGHT rail end area, PASS
	pass

func is_skater_in_complete_area():
	if(direction == "LEFT"):
		return rail.get_left_rail_end().overlaps_area(skater.get_board_area_2d)
	else:
		return rail.get_right_rail_end().overlaps_area(skater.get_board_area_2d)
	
	

# 
