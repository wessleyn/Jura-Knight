extends CharacterBody2D

const SPEED = 130.0
const SHIP_SPEED = 150
const JUMP_VELOCITY = -300.0

var prevPosition = 0
var highestPosition = 0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ship: AnimatableBody2D = $"../Ship"
@onready var game_manager: CanvasLayer = %GameManager


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
		

func _ready() -> void:
	#mark the starting point as the highest distance moved
	highestPosition = position.x
	prevPosition = highestPosition

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
	
	if(position.x > highestPosition): 
		game_manager.addPoint(0.125) # increase score based on world exploration
		highestPosition = position.x #mark new highest position reached
	
	if(position.x != prevPosition):
		# increase thirst by distance 'moved' irregardless of direction
		game_manager.increaseThirst(0.0625) 
		prevPosition = position.x # mark the new previous position 
