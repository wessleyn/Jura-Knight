extends CharacterBody2D

const SHIP_SPEED = 150
const JUMP_VELOCITY = -300.0

var prevPosition = 0
var highestPosition = 0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ship: AnimatableBody2D = $"../Ship"
@onready var game_manager: CanvasLayer = %GameManager
@onready var healing: AnimatedSprite2D = $Healing
@onready var water_kill_zone: Area2D = $"../Water Kill Zone"


func enableMovement(direction):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if direction > 0: 
		animated_sprite.flip_h = false 
	elif direction < 0: 
		animated_sprite.flip_h = true 
		
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("jump")

	if direction:
		velocity.x = direction * Global.Knight_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Global.Knight_SPEED)
		

func _ready() -> void:
	#mark the starting point as the highest distance moved
	highestPosition = position.x
	prevPosition = highestPosition

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction := Input.get_axis("move_left", "move_right")
	
	var debugKey = Input.is_action_just_pressed("ui_text_backspace")
	if(debugKey): isKilled = true
	
	if isKilled:
		getKilled()
	elif Global.onShip and bool(direction) and !Global.shipDocked:
		ship.position.x  +=  direction * SHIP_SPEED *  delta
		position.x += direction * SHIP_SPEED * delta 
	else:
		enableMovement(direction)
		move_and_slide()
	
	if(position.x > highestPosition): 
		game_manager.addPoint(0.125) 
		highestPosition = position.x
	
	if(position.x != prevPosition):
		# increase thirst by distance 'moved' irregardless of direction
		game_manager.increaseThirst(0.0625) 
		prevPosition = position.x # mark the new previous position 

var tookHealing = false
var isKilled = false

func takeHealing():
	healing.play("healing") 
	tookHealing = true

func _on_healing_animation_finished() -> void:
	if(tookHealing):
		healing.play("normal")  
		tookHealing = false

func getKilled():
	isKilled = true
	animated_sprite.play("death")
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if isKilled and animated_sprite.animation == "death":
		isKilled = false
		water_kill_zone.player_died(self, true)
