extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the Knight direction -1 (left)  and 1 (right)
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip The Knight Direction
	if direction > 0: # moving to the right
		animated_sprite.flip_h = false # move to the left
	elif direction < 0: # vice versa
		animated_sprite.flip_h = true 
		
	# Play Animations
	if is_on_floor():
		if direction == 0: # and not moving
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: # then you're in the air
		animated_sprite.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
