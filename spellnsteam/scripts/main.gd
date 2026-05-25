extends Node2D

@onready var current_map = $CurrentMap
@onready var player = $Player

func change_map(path):
	print("CARREGANDO MAPA:", path)
	# Remove mapa antigo
	if current_map.get_child_count() > 0:
		current_map.get_child(0).queue_free()

	# Carrega novo mapa
	var new_map = load(path).instantiate()
	current_map.add_child(new_map)
	await get_tree().process_frame
	
	print("SPAWN PEDIDO:", GameManager.next_spawn)
	var spawn_path = "SpawnPoints/" + GameManager.next_spawn
	
	print("PROCURANDO:", spawn_path)
	var spawn = new_map.get_node_or_null(spawn_path)

	if spawn == null:
		print("SPAWN NÃO ENCONTRADO")
		return

	print("SPAWN ENCONTRADO:", spawn.global_position)
	player.global_position = spawn.global_position
	player.visible = true
	player.process_mode = Node.PROCESS_MODE_INHERIT
	
	await get_tree().create_timer(0.1).timeout
	GameManager.changing_map = false
	
	print("PLAYER MOVIDO:", player.global_position)
	print("\n\n")
