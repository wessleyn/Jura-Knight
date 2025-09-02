extends Area2D

@onready var timer: Timer = $Timer
@onready var game_over_label: Label = $GameOverCanvas/GameOverLabel

func _on_body_entered(knight: Node2D) -> void:
	Engine.time_scale = 0.5
	knight.get_node("CollisionShape2D").queue_free()
	game_over_label.visible = true
	timer.start() # create a delay before the game end

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	Global.shipDocked = false
	Global.onShip = true
	get_tree().reload_current_scene() # reload the game
