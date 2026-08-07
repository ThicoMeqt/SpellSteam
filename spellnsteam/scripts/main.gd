extends Node2D

@onready var current_map = $CurrentMap
@onready var player = $Player
@onready var fade = $ColorRect
@onready var nighttime = $nighttime

func _ready() -> void:
	nighttime.visible = false
	fade.modulate.a = 0.0
	GameManager.current_sauna = 0
	GameManager.dormir.connect(mimir)

func change_map(path):
	# Remove mapa antigo
	if current_map.get_child_count() > 0:
		current_map.get_child(0).queue_free()

	# Carrega novo mapa
	var new_map = load(path).instantiate()
	current_map.add_child(new_map)
	var allow := false
	if new_map.get_script():
		allow = new_map.get("allow_rune")
		if allow != false and allow != true:
			allow = false
	GameManager.allow_rune = allow
	GameManager.map_changed.emit()
	await get_tree().process_frame
	var spawn_path = "SpawnPoints/" + GameManager.next_spawn
	var spawn = new_map.get_node_or_null(spawn_path)

	if spawn == null:
		return

	player.global_position = spawn.global_position
	player.visible = true
	player.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.1).timeout
	GameManager.changing_map = false

func mimir():
	if GameManager.sleeping:
		return
	GameManager.sleeping = true
	fade.visible = true
	GameManager.player_mov = false
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1.5)
	await tween.finished
	if GameManager.is_daytime == true:
		GameManager.is_daytime = false
		nighttime.visible = true
		GameManager.remaining_actions = GameManager.max_night_actions
	elif GameManager.is_daytime == false:
		GameManager.is_daytime = true
		nighttime.visible = false
		GameManager.current_day += 1
		GameManager.remaining_actions = GameManager.max_day_actions
	GameManager.actions_changed.emit(GameManager.remaining_actions)
	GameManager.ja_dormiu.emit()
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 1.5)
	await tween.finished
	fade.visible = false
	GameManager.player_mov = true
	GameManager.sleeping = false
