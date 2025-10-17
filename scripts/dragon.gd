extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var anim = sprite.animation

	if anim == 'fly_left' or anim == 'fly_right':
		collision.rotation = 80
	else: 
		collision.rotation = 0
