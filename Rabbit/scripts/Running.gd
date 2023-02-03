extends PlayerState


func enter(_msg := {}) -> void:
	pass


func physics_update(_delta: float) -> void:
	
	var movement_vector = Vector2(rabbit.angle_velocity,0.0).rotated(rabbit.direction)
	movement_vector.y = movement_vector.y / 2
	var collision = rabbit.move_and_collide(movement_vector*_delta)
	if collision:
		rabbit.angle_velocity = 0
		print(collision.collider.name)
	
	var speedchange = float(Input.is_action_pressed("ui_up")) -\
		 float(Input.is_action_pressed("ui_down"))
	rabbit.angle_velocity += speedchange*rabbit.velocity_change*_delta
	
	var turnsence = int(Input.is_action_pressed("ui_right")) -\
		int(Input.is_action_pressed("ui_left"))
	rabbit.direction += float(turnsence)*rabbit.turnspeed
	rabbit.direction = wrapf(rabbit.direction, 2* PI, 0)
	
	if rabbit.angle_velocity < rabbit.max_walk_speed:
		state_machine.transition_to("Walk", {})
	elif rabbit.angle_velocity > rabbit.max_run_speed:
		rabbit.angle_velocity = rabbit.max_run_speed


func update(_delta: float) -> void:
	
	if rabbit.direction <= 0.25*PI or rabbit.direction > 1.75 * PI:
		setAnimationRunRight()
	elif rabbit.direction <= 0.75*PI and rabbit.direction > 0.25 * PI:
		setAnimationRunDown()
	elif rabbit.direction <= 1.25*PI and rabbit.direction > 0.75 * PI:
		setAnimationRunLeft()
	elif rabbit.direction > 1.25*PI and rabbit.direction <= 1.75 * PI:
		setAnimationRunUp()


func setAnimationRunRight():
	
	rabbit.rabbitAnimation.scale.x = 1
	rabbit.rabbitAnimation.animation = "running_right"


func setAnimationRunLeft():
	
	rabbit.rabbitAnimation.animation = "running_right"
	rabbit.rabbitAnimation.scale.x = -1


func setAnimationRunDown():
	
	rabbit.rabbitAnimation.scale.x = 1
	rabbit.rabbitAnimation.animation = "running_down"


func setAnimationRunUp():
	
	rabbit.rabbitAnimation.scale.x = -1
	rabbit.rabbitAnimation.animation = "running_up"


