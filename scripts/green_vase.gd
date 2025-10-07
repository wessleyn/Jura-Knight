extends Area2D

@onready var game_manager: CanvasLayer = %GameManager

func _on_body_entered(body: Node2D) -> void:
	game_manager.takeHealing(15)
	self.queue_free()
	body.get_node("AnimationPlayer").play("Quenched")
