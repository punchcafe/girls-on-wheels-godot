static func get_velocity_component_in_rail_direction(velocity: Vector2, rail_direction: Vector2) -> Vector2:
	var rail_angle = rail_direction.angle()
	var velocity_angle = velocity.angle()
	var angle_difference = rail_angle - velocity_angle
	
	var projected_rail_magnitude = velocity.length()*cos(angle_difference)
	
	var projected_rail_x = projected_rail_magnitude*cos(rail_angle)
	var projected_rail_y = projected_rail_magnitude*sin(rail_angle)
	
	return Vector2(projected_rail_x,projected_rail_y)
