extends Area2D

@onready var timer: Timer = $Timer
@onready var game_over_label: Label = $GameOverCanvas/GameOverLabel

var isKilled: bool = false

func _on_body_entered(knight: Node2D) -> void:
	player_died(knight)

func player_died(knight: Node2D, killed=false) -> void:
	if knight.has_node("CollisionShape2D"):
		knight.get_node("CollisionShape2D").queue_free()

	isKilled = killed
	Engine.time_scale = 0.3
	
	game_over_label.visible = true	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	Global.Knight_SPEED = 130
	get_tree().reload_current_scene()
