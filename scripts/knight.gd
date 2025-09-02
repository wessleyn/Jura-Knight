extends CharacterBody2D

const SPEED = 130.0
const SHIP_SPEED = 150
const JUMP_VELOCITY = -300.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ship: AnimatableBody2D = $"../Ship"

func enableMovement(direction):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
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

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the Knight direction -1 (left)  and 1 (right)
	var direction := Input.get_axis("move_left", "move_right")
	
	if Global.onShip and bool(direction) and !Global.shipDocked:
		ship.position.x  +=  direction * SHIP_SPEED *  delta
		position.x += direction * SHIP_SPEED * delta 
	else:
		enableMovement(direction)
		move_and_slide()
