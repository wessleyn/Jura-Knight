extends Area2D

@onready var game_manager: CanvasLayer = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	game_manager.relieveThirst(10)
	animation_player.play("drink")
