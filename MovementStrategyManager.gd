extends Node

var strategies_by_status = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		strategies_by_status[child.get_applicable_status()] = child
	print(strategies_by_status)
	pass # Replace with function body.

func get_strategy_for_status(status):
	return strategies_by_status[status]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
