extends Control

@onready var menu: VBoxContainer = $Menu
@onready var options: Panel = $Options

func _ready():
	menu.visible = true
	options.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed() -> void:
	options.show()
	menu.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_return_pressed() -> void:
	_ready()
