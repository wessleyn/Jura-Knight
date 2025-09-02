extends AnimatableBody2D

@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ship rendered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_right.is_colliding():
		Global.shipDocked = true
