extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manager: CanvasLayer = %GameManager

func _on_body_entered(body: Node2D) -> void:
	game_manager.addCoin()
	animation_player.play("pickup")
