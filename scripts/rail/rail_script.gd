extends Area2D

signal lol

var _rail_angle = Vector2(2, 0)

func get_rail_angle():
	return self._rail_angle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_type(): 
	return "Rail"
	
func get_left_rail_end():
	# TODO
	pass

func get_right_rail_end():
	# TODO	
	pass
