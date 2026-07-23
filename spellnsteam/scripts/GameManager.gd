extends Node

var player_mov = true
var player_enable = true

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO MAPA
var next_spawn = ""
var changing_map = false

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO DIA
var current_day = 1
var is_daytime = true

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DAS ACOES
var max_day_actions = 3
var max_night_actions = 2
var remaining_actions = 3

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#STATS DO PLAYER
var sp_comfort = 0
var sp_water = 0
var sp_popularity = 0

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
var sr1_comfort = 1
var sr1_water = 1
var sr1_popularity = 1
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 2
var sr2_comfort = 2
var sr2_water = 2
var sr2_popularity = 2
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 3
var sr3_comfort = 3
var sr3_water = 3
var sr3_popularity = 3

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SISTEMA DE ACOES
signal actions_changed(valor)

func gastar_fogo(amount := 1):
	remaining_actions -= amount
	actions_changed.emit(remaining_actions)

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
