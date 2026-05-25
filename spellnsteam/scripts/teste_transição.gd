extends Area2D

@export_file("*.tscn") var target_scene
@export var spawn_name : String

func _on_body_entered(body):
	if body.name != "Player":
		return

	if GameManager.changing_map:
		return
	GameManager.changing_map = true

	GameManager.next_spawn = spawn_name

	get_tree().current_scene.call_deferred(
		"change_map",
		target_scene
	)
