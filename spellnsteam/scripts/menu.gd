extends Control

@onready var fade = $ColorRect

func _on_play_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1.0)
	tween.finished.connect(func ():
		get_tree().change_scene_to_file("res://scenes/main.tscn"))

func _on_quit_pressed() -> void:
	get_tree().quit()
