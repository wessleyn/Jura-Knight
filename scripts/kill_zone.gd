extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(knight: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	knight.get_node("CollisionShape2D").queue_free()
	timer.start() # create a delay before the game end


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene() # reload the game
