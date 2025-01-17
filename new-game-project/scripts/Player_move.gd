extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x!=0:
			if velocity.x>0:
				$AnimatedSprite2D.animation="run"
				$AnimatedSprite2D.flip_h = false
			elif velocity.x<0:
				$AnimatedSprite2D.animation="run"
				$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation="idle"

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			$AnimatedSprite2D.animation="idle"

	move_and_slide()
