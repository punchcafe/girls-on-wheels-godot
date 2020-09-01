extends Node

const SkaterStates = preload("res://SkaterStates.gd")

var _permitted_state_transitions = {
	SkaterStates.SKATING: [SkaterStates.WALL_HANGING, SkaterStates.GRINDING, SkaterStates.RUNNING],
	SkaterStates.RUNNING: [SkaterStates.SKATING],
	SkaterStates.GRINDING: [SkaterStates.SKATING, SkaterStates.GRINDING],
	SkaterStates.WALL_HANGING: [SkaterStates.SKATING]
}

var _grinding_rail
var _hanging_wall

var _current_state

func _ready():
	self._current_state = SkaterStates.SKATING
	self._grinding_rail = null
	self._hanging_wall = null

func _transition_state_to(state) -> bool:
	if(self._permitted_state_transitions[self._current_state].has(state)):
		self._current_state = state
		return true
	else:
		return false

func get_current_state():
	return _current_state

func grind_on_rail(rail) -> bool:
	if(_transition_state_to(SkaterStates.GRINDING)):
		self._grinding_rail = rail
		return true
	else:
		return false
	
func release_grind_on_rail(rail) -> bool:
	if(_grinding_rail == rail):
		# Only release rail if it's the active rail
		return _transition_state_to(SkaterStates.SKATING)
	else:
		return false
func jump_off_rail():
	return _transition_state_to(SkaterStates.SKATING)

func mount() -> bool:
	return _transition_state_to(SkaterStates.SKATING)
	
func dismount() -> bool:
	return _transition_state_to(SkaterStates.RUNNING)
	
func get_grinding_rail():
	return _grinding_rail
