extends PlayerState


func enter(_msg := {}) -> void:
	rabbit.angle_velocity = 0.0


func physics_update(_delta: float) -> void:
	rabbit.rabbitAnimation.animation = "looking_right"
	var turnsence = int(Input.is_action_pressed("ui_right")) -\
		int(Input.is_action_pressed("ui_left"))
	rabbit.direction += float(turnsence)*rabbit.turnspeed
	rabbit.direction = wrapf(rabbit.direction, 2* PI, 0)
	if rabbit.direction < PI/2.0 or rabbit.direction >= 3.0 * PI /2.0:
		rabbit.rabbitAnimation.scale.x = 1
	else:
		rabbit.rabbitAnimation.scale.x = -1
	if Input.is_action_pressed("ui_up"):
		rabbit.angle_velocity = rabbit.min_walk_speed
		state_machine.transition_to("Walk", {})

