extends Area2D


var railAngle = Vector2(2, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rail_body_entered(body):
	if(body.grindingRail != null && body.grindingRail != self):
		# Skater has come from other rail
		body.grindingRail = self
	elif Input.is_action_pressed("ollie_button"):
		print ("you're going to grind!")
		body.grindingRail = self
		
	pass # Replace with function body.


func _on_Rail_body_shape_exited(body_id, body, body_shape, area_shape):
	if(body.grindingRail == self):
		print("bye felicia!")
		# Avoid doubling
		body.grindingRail = null
	pass # Replace with function body.
