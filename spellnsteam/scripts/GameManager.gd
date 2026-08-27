extends Node

var player_mov = true
var player_enable = true
@warning_ignore("unused_signal")
signal dialogo_sabotar_start
@warning_ignore("unused_signal")
signal dialogo_sabotar_end
@warning_ignore("unused_signal")
signal dialogo_floresta_start
@warning_ignore("unused_signal")
signal dialogo_floresta_end
@warning_ignore("unused_signal")
signal desativar_btns
@warning_ignore("unused_signal")
signal ativar_btns

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO MAPA
var next_spawn = ""
var changing_map = false
var allow_rune := false
var current_sauna = 0
@warning_ignore("unused_signal")
signal map_changed

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DO DIA
var current_day = 1
var is_daytime = true
var sleeping = false
@warning_ignore("unused_signal")
signal dormir
@warning_ignore("unused_signal")
signal ja_dormiu

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#MANAGEMENT DAS ACOES
var max_day_actions = 3
var max_night_actions = 2
var remaining_actions = 3
signal actions_changed(valor)

func gastar_fogo(amount):
	remaining_actions -= amount
	actions_changed.emit(remaining_actions)

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#STATS DO PLAYER
var player_name = "Safas"
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
var itens_get = {
	"madeira": false,
	"carvao": false,
	"up_toalha": false,
	"up_eucalipto": false,
	"up_cerca": false
}
var itens_comprados = {
	"toalha": false,
	"cerca1": false,
	"cerca2": false
}

signal inventory_changed
@warning_ignore("unused_signal")
signal update_loja

func add_item(item_name: String):
	inventory[item_name] += 1
	itens_get[item_name] = true
	inventory_changed.emit()

func remove_item(item_name: String):
	if inventory[item_name] == 0:
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
	"confort": 2,
	"water": 3,
	"popularity": 3
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 2
var sr2_stats = {
	"confort": 4,
	"water": 2,
	"popularity": 2
}

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#SAUNA RIVAL 3
var sr3_stats = {
	"confort": 3,
	"water": 1,
	"popularity": 5
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
