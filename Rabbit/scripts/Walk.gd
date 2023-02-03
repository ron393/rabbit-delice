extends PlayerState


func enter(_msg := {}) -> void:
	rabbit.rabbitAnimation.animation = "walking_right"
	
	

func physics_update(_delta: float) -> void:
	
	var movement_vector = Vector2(rabbit.angle_velocity,0.0).rotated(rabbit.direction)
	movement_vector.y = movement_vector.y / 2
	var collision = rabbit.move_and_collide(movement_vector*_delta)
	if collision:
		rabbit.angle_velocity = 0
		print(collision.collider.name)
	else: 
		print("no collision")
	
	if rabbit.direction < 0.5 * PI or rabbit.direction >= 1.5 * PI:
		rabbit.rabbitAnimation.scale.x = 1
	else:
		rabbit.rabbitAnimation.scale.x = -1

	var speedchange = float(Input.is_action_pressed("ui_up")) - float(Input.is_action_pressed("ui_down"))
	rabbit.angle_velocity += speedchange*rabbit.velocity_change*_delta
#
	var turnsence = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	rabbit.direction += turnsence *rabbit.turnspeed
	rabbit.direction = wrapf(rabbit.direction, 2* PI, 0)
	if rabbit.angle_velocity < rabbit.min_walk_speed:
		state_machine.transition_to("Idle", {})
	elif rabbit.angle_velocity > rabbit.max_walk_speed:
		state_machine.transition_to("Running", {})
	

