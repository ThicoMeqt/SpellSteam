extends Area2D

@export_file("*.tscn") var target_scene
@export var spawn_name : String

# NEW
@export var costs_action := false

func _on_body_entered(body):
	if body.name != "Player" or GameManager.changing_map:
		return
	if costs_action:
		if !GameManager.spend_action():
			return
	if target_scene == "uid://dq5titpty1unv" and GameManager.is_daytime == false:
		body.position = Vector2(600,100)
		GameManager.dialogo_floresta_start.emit()
		return
	GameManager.changing_map = true
	GameManager.next_spawn = spawn_name
	get_tree().current_scene.call_deferred(
		"change_map",
		target_scene
	)
