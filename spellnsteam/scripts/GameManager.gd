extends Node

#MANAGEMENT DO MAPA
var next_spawn = ""
var changing_map = false

#MANAGEMENT DO DIA
var current_day = 1
var is_daytime = true

#MANAGEMENT DAS ACOES
var max_day_actions = 3
var max_night_actions = 2
var remaining_actions = 3

#STATS DO PLAYER
var water = 0
var comfort = 0
var popularity = 0

#INVENTARIO PLAYER
var wood = 0
var coal = 0
var shopitem = 0

#SAUNA RIVAL 1
var rival_water = 2
var rival_comfort = 2
var rival_popularity = 2

#SISTEMA DE ACOES
func spend_action(amount := 1):
	if remaining_actions < amount:
		print("NO ACTIONS LEFT")
		return false
	remaining_actions -= amount
	print("Remaining actions:", remaining_actions)
	return true

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
