extends Node

var player_mov = true
var player_enable = true

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO MAPA
var next_spawn = ""
var changing_map = false
var allow_rune := false
var current_sauna = 0
signal map_changed

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO DIA
var current_day = 1
var is_daytime = true
var sleeping = false
signal dormir
signal ja_dormiu

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DAS ACOES
var max_day_actions = 3
var max_night_actions = 2
var remaining_actions = 3
signal actions_changed(valor)

func gastar_fogo(amount := 1):
	remaining_actions -= amount
	actions_changed.emit(remaining_actions)

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#STATS DO PLAYER
var sauna_stats = {
	"confort": 0,
	"water": 0,
	"popularity": 0
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#INVENTARIO PLAYER
var inventory = {
	"madeira": 0,
	"carvao": 0,
	"up_toalha": 0,
	"up_eucalipto": 0,
	"up_cerca": 0
}

signal inventory_changed

func add_item(item_name: String):
	if !inventory.has(item_name):
		return
	inventory[item_name] += 1
	inventory_changed.emit()

func remove_item(item_name: String):
	if !inventory.has(item_name) or inventory[item_name] == 0:
		return
	inventory[item_name] -= 1
	inventory_changed.emit()

func coletar(item):
	if remaining_actions <= 0:
		return
	add_item(item)
	gastar_fogo(1)


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 1
var sr1_stats = {
	"confort": 1,
	"water": 1,
	"popularity": 1
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 2
var sr2_stats = {
	"confort": 2,
	"water": 2,
	"popularity": 2
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 3
var sr3_stats = {
	"confort": 3,
	"water": 3,
	"popularity": 3
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SISTEMA DIA/NOITE
func end_phase():
	# DAY -> NIGHT
	if is_daytime:
		is_daytime = false
		remaining_actions = max_night_actions
		print("Night begins")

	# NIGHT -> NEXT DAY
	else:
		is_daytime = true
		current_day += 1
		remaining_actions = max_day_actions

		print("Day", current_day, "begins")
