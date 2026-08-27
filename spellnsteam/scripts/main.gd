extends Node2D

@onready var current_map = $CurrentMap
@onready var player = $Player
@onready var fade = $ColorRect
@onready var nighttime = $nighttime
@onready var lbl_dia1 = $ColorRect/lbl_dia1
@onready var lbl_dia2 = $ColorRect/lbl_dia2
@onready var block_dias = $ColorRect/Control

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
	block_dias.visible = false
	lbl_dia2.visible = false
	lbl_dia1.visible = true
	var pos1_og = lbl_dia1.get_screen_position()
	var pos2_og = lbl_dia2.get_screen_position()
	GameManager.sleeping = true
	fade.visible = true
	GameManager.player_mov = false
	if GameManager.is_daytime == true:
		lbl_dia1.text = "DIA %s" %[str(GameManager.current_day)]
		lbl_dia2.text = "NOITE %s" %[str(GameManager.current_day)]
	elif GameManager.is_daytime == false:
		lbl_dia1.text = "NOITE %s" %[str((GameManager.current_day))]
		lbl_dia2.text = "DIA %s" %[str((GameManager.current_day)+1)]
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
	block_dias.visible = true
	lbl_dia2.visible = true
	tween = create_tween()
	tween.tween_property(lbl_dia1, "position:y", 70, 1.5)
	var tween2 = create_tween()
	tween2.tween_property(lbl_dia2, "position:y", 250, 1.5)
	await tween.finished
	block_dias.visible = false
	lbl_dia1.visible = false
	if GameManager.current_day == 7:
		get_tree().change_scene_to_file("res://scenes/finalizacao.tscn")
		GameManager.player_enable = false
	else:
		tween = create_tween()
		tween.tween_property(fade, "modulate:a", 0, 1.5)
		await tween.finished
		fade.visible = false
		lbl_dia1.position = pos1_og
		lbl_dia2.position = pos2_og
		GameManager.player_mov = true
		GameManager.sleeping = false
		GameManager.ativar_btns.emit()
