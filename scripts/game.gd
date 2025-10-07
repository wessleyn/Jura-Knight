extends Node

@onready var game_manager: CanvasLayer = %GameManager

func _ready() -> void:
	game_manager.show()
