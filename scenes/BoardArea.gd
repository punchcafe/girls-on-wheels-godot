extends Area2D

signal rail_area_entered(rail)
signal rail_area_exited(rail)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BoardArea_area_entered(area):
	if(area.get_type() == "Rail"):
		emit_signal("rail_area_entered", area)
	pass # Replace with function body.


func _on_BoardArea_area_exited(area):
	if(area.get_type() == "Rail"):
		emit_signal("rail_area_exited", area)
	pass # Replace with function body.
