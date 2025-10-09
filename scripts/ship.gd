extends AnimatableBody2D

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_top: RayCast2D = $RayTop

func _process(delta: float) -> void:
	if ray_right.is_colliding() or ray_left.is_colliding():
		Global.shipDocked = true
	else:
		Global.shipDocked = false
	
	if ray_top.is_colliding():
		Global.onShip = true
	else:
		Global.onShip = false
	
	var unDock = Input.is_action_just_pressed("udock")
	
	# Nudge ship out of dock
	if(Global.shipDocked and unDock):
		if(ray_right.is_colliding()):
			self.position.x -= 10
		else: # its ray left
			self.position.x += 10
