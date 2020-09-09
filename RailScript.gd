extends Area2D


var _rail_angle = Vector2(2, 0)

func get_rail_angle():
	return self._rail_angle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rail_body_entered(body):
	if Input.is_action_pressed("ollie_button"):
		body._state_manager.grind_on_rail(self)


func _on_Rail_body_shape_exited(body_id, body, body_shape, area_shape):
	print("bye!")
	body._state_manager.release_grind_on_rail(self)
