extends Area2D

@onready var game_manager: CanvasLayer = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	animation_player.play("pickup")
	body.takeHealing()
	game_manager.takeHealing(15)
