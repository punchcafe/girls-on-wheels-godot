extends Node

var active;
var tasks;
var current_task_index;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var current_task = tasks[current_task_index]
	current_task.apply_delta(delta)
	if(current_task.has_finished()):
		if(current_task.was_successful()):
			complete_task()
		else:
			fail_level()
	pass
	
func start():
	current_task_index = 0;
	current_task_index[0].prepare();
	current_task_index[0].start();
	
func fail_level():
	pass
	
func win_level():
	pass
	
func complete_task():
	current_task_index = current_task_index + 1
	if(current_task_index >= tasks.size()):
		win_level();
				
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
